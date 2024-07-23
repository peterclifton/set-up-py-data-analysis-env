<# 
.SYNOPSIS
	Creats a python virtual environment (needs python to be present).
.DESCRIPTION
	This PowerShell script sets up a python virtual env for data analysis (expects python to be present)
.NOTES
	Author: Peter Clifton  | License: MIT 
 #>


try {

    # Check that python is installed before proceeding
    Write-Host -ForegroundColor Cyan       "`n:: Checking to make sure python is installed on this machine ..."
    try {
        python -c "pass"
        Write-Host -ForegroundColor Green    "   Result: [PASS] ... python found, will proceed with virtual env setup ..."
    
    }
    catch {
        Write-Host -ForegroundColor Yellow   "   Result: [FAIL] ... python not found, exiting ..."
        exit
    }


    # Check for existance of folder named myvenv
    Write-Host -ForegroundColor Cyan       "`n:: Checking to make sure no existing folder called myvenv at this location ..."
    $path = 'myvenv'
    if(Test-Path -Path $path) {
        Write-Host -ForegroundColor Yellow   "   Result: [Fail] ... ${path} already exists, exiting..."
        exit

    } else {

         Write-Host -ForegroundColor Green    "   Result: [PASS] ... "
        

        # making sure we are not currently in a py virtual env
         try {
            deactivate
            Write-Host -ForegroundColor Cyan "`n::deactivated current python virtual environment"
         }
         catch {}
        
        # creating py virtual env
        Write-Host -ForegroundColor Cyan "`n:: Creating python virtual environment: ${path}"
        python -m venv myvenv

        # activating the virtual env
        Write-Host -ForegroundColor Cyan "`n:: activating new virtual env 'myvenv'"
        .\myvenv\Scripts\Activate.ps1

        Write-Host -ForegroundColor Cyan "`n:: installing modules`n"
        # installing (in the virtual env) the module we require
        python -m pip install --upgrade pip
        python -m pip install ipython
        python -m pip install numpy
        python -m pip install pandas
        python -m pip install tabulate
        python -m pip install openpyxl
        python -m pip install pywin32
        python -m pip install pyxlsb
        python -m pip install seaborn
        python -m pip install statsmodels
        python -m pip install xlrd

        #python -m pip install pyinstaller

        # exiting from virtual env
        deactivate 
        Write-Host -ForegroundColor Cyan "`n:: deactivated 'myvenv'`n"
        Write-Host -ForegroundColor Green "Done!"
        Write-Host -ForegroundColor Gray  "Hint: To activate virtual environment try: 'myvenv\Scripts\activate.ps1'"
        Write-Host -ForegroundColor Gray  "      then 'python -m IPython' to open ipython console`n"
     }


} catch {
	Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
}
