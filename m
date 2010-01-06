From: Miles Lane <miles.lane@gmail.com>
Date: Wed, 06 Jan 2010 18:35:59 +0000
Subject: Re: 2.6.33-rc3 -- Intel 945GME (inteldrmfb) -- Two Tux images
Message-Id: <a44ae5cd1001061035n65b5a41flc84a81285df4279c@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <a44ae5cd1001060916s4db1d94fsb7e012ab80ce6add@mail.gmail.com>
	 <1262801263.4049.53.camel@laptop>
In-Reply-To: <1262801263.4049.53.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, linux-fbdev@vger.kernel.org

On Wed, Jan 6, 2010 at 1:07 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, 2010-01-06 at 12:16 -0500, Miles Lane wrote:
>> For a long time I have gotten two pictures of Tux showing up when I
>> include the Tux display option in my custom kernel builds.
>
> Doesn't it show one for each cpu in the system?

I know this is cosmetic, but could we change this behavior and just
show one Tux on all systems?  As a software tester, this just looks
like a bug.  Alternatively, let's put labels under the Tux images
showing "CPU (N)", "CPU (N+1)", ....

This seems like a much better way to know the state of your CPUs:

# cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 28
model name	: Intel(R) Atom(TM) CPU N280   @ 1.66GHz
stepping	: 2
cpu MHz		: 1667.000
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 0
initial apicid	: 0
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc
arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl est tm2
ssse3 xtpr pdcm movbe lahf_lm
bogomips	: 3325.27
clflush size	: 64
cache_alignment	: 64
address sizes	: 32 bits physical, 32 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 28
model name	: Intel(R) Atom(TM) CPU N280   @ 1.66GHz
stepping	: 2
cpu MHz		: 1000.000
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 1
initial apicid	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc
arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl est tm2
ssse3 xtpr pdcm movbe lahf_lm
bogomips	: 3324.83
clflush size	: 64
cache_alignment	: 64
address sizes	: 32 bits physical, 32 bits virtual
power management:

And:

# dmesg | grep -i cpu
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
ACPI: SSDT 7f7aeb40 004F0 (v01  PmRef    CpuPm 00003000 INTL 20051117)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
setup_percpu: NR_CPUS:5 nr_cpumask_bits:5 nr_cpu_ids:2 nr_node_ids:1
PERCPU: Embedded 15 pages/cpu @c6c00000 s39448 r0 d21992 u2097152
pcpu-alloc: s39448 r0 d21992 u2097152 alloc=3D1*4194304
pcpu-alloc: [0] 0 1
Initializing CPU#0
SLUB: Genslabs=13, HWalignd, Order=3D0-3, MinObjects=3D0, CPUs=3D2, Nodes=
=3D1
RCU-based detection of stalled CPUs is enabled.
CPU 0 irqstacks, hard=C6c00000 soft=C6c01000
Initializing cgroup subsys cpuacct
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 5 MCE banks
CPU0: Thermal monitoring enabled (TM2)
CPU0: Intel(R) Atom(TM) CPU N280   @ 1.66GHz stepping 02
CPU 1 irqstacks, hard=C6e00000 soft=C6e01000
Initializing CPU#1
Brought up 2 CPUs
ACPI: SSDT 7f7ae180 001FA (v01  PmRef  Cpu0Ist 00003000 INTL 20051117)
ACPI: SSDT 7f7ae410 00724 (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
ACPI: SSDT 7f7ae0b0 000CC (v01  PmRef  Cpu1Ist 00003000 INTL 20051117)
ACPI: SSDT 7f7ae380 00085 (v01  PmRef  Cpu1Cst 00003000 INTL 20051117)
HPET: 3 timers in total, 0 timers will be used for per-cpu timer
cpu0(2) debug files 135
cpu1(2) debug files 135
microcode: CPU0 sig=3D0x106c2, pf=3D0x4, revision=3D0x212
microcode: CPU1 sig=3D0x106c2, pf=3D0x4, revision=3D0x212
cpuidle: using governor ladder
cpuidle: using governor menu
