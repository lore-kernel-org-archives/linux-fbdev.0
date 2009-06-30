From: Michal Suchanek <hramrach@centrum.cz>
Subject: Re: [Bugme-new] [Bug 13285] New: INTELFB:
	Colors display incorrectly
Date: Tue, 30 Jun 2009 13:35:11 +0200
Message-ID: <a5d587fb0906300435i1a9a6f8exc028ad5041e440dd@mail.gmail.com>
References: <bug-13285-10286@http.bugzilla.kernel.org/>
	<20090512151934.d7e6c54e.akpm@linux-foundation.org>
	<20090517081743.92002707.krzysztof.h1@poczta.fm>
	<20090516231932.2e02647b.akpm@linux-foundation.org>
	<20090517123032.2b8bad00.krzysztof.h1@poczta.fm>
	<a5d587fb0905170807j4cf60ce7ucf675cc6161e7850@mail.gmail.com>
	<20090530135833.6a2c1bb2.krzysztof.h1@poczta.fm>
	<20090602131855.1d69f442.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20090602131855.1d69f442.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bugzilla-daemon@bugzilla.kernel.org, samanddeanus@yahoo.com, linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net

Hello

2009/6/2 Andrew Morton <akpm@linux-foundation.org>:
> On Sat, 30 May 2009 13:58:33 +0200
> Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
>
>> The intelfb driver sets color map depending on currently active pipe. However, if an LVDS
>> display is attached (like in laptop) the active pipe variable is never set. The default value is
>> PIPE_A and can be wrong.
>> Set up the pipe variable during driver initialization after hardware state was read.
>>
>> Also, the detection of the active display (and hence the pipe) is wrong. The pipes are assigned
>> to so called planes. Both pipes are always enabled on my laptop but only one plane is enabled
>> (the plane A for the CRT or the plane B for the LVDS). Change active pipe detection code
>> to take into account a status of the plane assigned to each pipe.
>>
>> The problem is visible in the 8 bpp mode if colors above 15 are used. The first 16 color
>> entries are displayed correctly.
>>
>> The graphics chip description is here (G45 vol. 3):
>> http://intellinuxgraphics.org/documentation.html
>>
>> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>>
>> ---
>> The second version of the fix to this problem. Now, it is much more sophisticated
>> based on the knowledge gained from documentation available at http://intellinuxgraphics.org/.
>>
>> It does not change a default behaviour (assumed pipe A) for all cases except the case that only
>> the plane assigned to the pipe B is active. It is enough to fix the issue for me.
>
> I queued this.
>
>> Please test it.
>
> But it would great be Dean and/or Michal were to be able to test it, please.
>

Sorry about the late reply.

In the end I could not test the patch on my system. Not only does the
patch not apply but intelfb fails to produce any screen output at all.
the command line is like this:

video=intelfb:mode=1280x1024 fbcon=rotate:1

Here is a boot with both intelfb and efifb. For some reason the efifb
is shown in this case but breaks so I thought I was looking at intelfb
because the output was different. Both geometry and colours are
broken. Part of the console (top, physical right) is invisible, part
(right, physical bottom) is not drawn (shows black initially and
garbage after switching to X and back).


Jun 29 12:50:30 uvt316-2 kernel: [    0.366168] efifb: dmi detected
Macmini1,1 - framebuffer at 80000000
(1024x768, stride 8192)
Jun 29 12:50:30 uvt316-2 kernel: [    0.366273] efifb: probing for efifb
Jun 29 12:50:30 uvt316-2 kernel: [    0.366486] efifb: framebuffer at
0x80000000, mapped to 0xf8100000, u
sing 6144k, total 6144k
Jun 29 12:50:30 uvt316-2 kernel: [    0.366496] efifb: mode is
1024x768x32, linelength=8192, pages=1
Jun 29 12:50:30 uvt316-2 kernel: [    0.366501] efifb: scrolling: redraw
Jun 29 12:50:30 uvt316-2 kernel: [    0.366508] efifb: Truecolor:
size=8:8:8:8, shift=24:16:8:0
Jun 29 12:50:30 uvt316-2 kernel: [    0.395938] Console: switching to
colour frame buffer device 96x64
Jun 29 12:50:30 uvt316-2 kernel: [    0.423483] fb0: EFI VGA frame buffer device
Jun 29 12:50:30 uvt316-2 kernel: [    0.427641] Linux agpgart interface v0.103
Jun 29 12:50:30 uvt316-2 kernel: [    0.427886] agpgart-intel
0000:00:00.0: Intel 945GM Chipset
Jun 29 12:50:30 uvt316-2 kernel: [    0.429006] agpgart-intel
0000:00:00.0: detected 16124K stolen memory
Jun 29 12:50:30 uvt316-2 kernel: [    0.432312] agpgart-intel
0000:00:00.0: AGP aperture is 256M @ 0x8000
0000
Jun 29 12:50:30 uvt316-2 kernel: [    0.432750] intelfb: Framebuffer
driver for Intel(R)
830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/945GME/965G/965GM
chipsets
Jun 29 12:50:30 uvt316-2 kernel: [    0.433387] intelfb: Version 0.9.6
Jun 29 12:50:30 uvt316-2 kernel: [    0.433626] intelfb 0000:00:02.0:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
Jun 29 12:50:30 uvt316-2 kernel: [    0.434067] intelfb: Cannot
reserve FB region.


Intelfb only. No console output.

Jun 29 14:16:18 uvt316-2 kernel: [    0.370014] Linux agpgart interface v0.103
Jun 29 14:16:18 uvt316-2 kernel: [    0.370037] agpgart-intel
0000:00:00.0: Intel 945GM Chipset
Jun 29 14:16:18 uvt316-2 kernel: [    0.370786] agpgart-intel
0000:00:00.0: detected 16124K stolen memory
Jun 29 14:16:18 uvt316-2 kernel: [    0.373808] agpgart-intel
0000:00:00.0: AGP aperture is 256M @ 0x8000
0000
Jun 29 14:16:18 uvt316-2 kernel: [    0.373876] intelfb: Framebuffer
driver for Intel(R)
830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/945GME/965G/965GM
chipsets
Jun 29 14:16:18 uvt316-2 kernel: [    0.373886] intelfb: Version 0.9.6
Jun 29 14:16:18 uvt316-2 kernel: [    0.373937] intelfb 0000:00:02.0:
PCI INT A -> GSI 16 (level, low) -> IRQ 16
Jun 29 14:16:18 uvt316-2 kernel: [    0.373960] intelfb: 00:02.0:
Intel(R) 945GM, aperture size 256MB, stolen memory 16124kB
Jun 29 14:16:18 uvt316-2 kernel: [    0.377376] intelfb: Non-CRT
device is enabled ( DVO port B ).  Disabling mode switching.
Jun 29 14:16:18 uvt316-2 kernel: [    0.377392] intelfb: Video mode
must be programmed at boot time.



Efifb only with video=efifb fbcon=rotate:1
Produces correct geometry but broken colours.

Jun 29 15:26:59 uvt316-2 kernel: [    0.364224] efifb: dmi detected
Macmini1,1 - framebuffer at 80000000
(1024x768, stride 8192)
Jun 29 15:26:59 uvt316-2 kernel: [    0.364328] efifb: probing for efifb
Jun 29 15:26:59 uvt316-2 kernel: [    0.364609] efifb: framebuffer at
0x80000000, mapped to 0xf8100000, u
sing 8192k, total 8192k
Jun 29 15:26:59 uvt316-2 kernel: [    0.364619] efifb: mode is
1280x1024x16, linelength=8192, pages=1
Jun 29 15:26:59 uvt316-2 kernel: [    0.364624] efifb: scrolling: redraw
Jun 29 15:26:59 uvt316-2 kernel: [    0.364631] efifb: Truecolor:
size=8:8:8:8, shift=24:16:8:0
Jun 29 15:26:59 uvt316-2 kernel: [    0.389698] Console: switching to
colour frame buffer device 128x80
Jun 29 15:26:59 uvt316-2 kernel: [    0.413244] fb0: EFI VGA frame buffer device

------------------------------------------------------------------------------
