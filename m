From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Fwd: Resetting secondary video adapter
Date: Fri, 10 Jan 2003 11:48:53 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030110194853.22138.qmail@web14904.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14904.mail.yahoo.com ([216.136.225.56])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18X5AD-0003Kx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 11:49:57 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

I have been getting requests for this. It is from the
svgalib people.....

--- Jon Smirl <jonsmirl@yahoo.com> wrote:
> Date: Sun, 5 Jan 2003 21:34:42 -0800 (PST)
> From: Jon Smirl <jonsmirl@yahoo.com>
> Subject: Resetting secondary video adapter
> To: dri-devel <dri-devel@lists.sourceforge.net>
> 
> I ran across this program for resetting secondary
> adapters. 
>
http://www.arava.co.il/matan/svgalib/hypermail/1660.html
> Inside of the download you can build vbios.vm86. The
> vm86 version worked on my Rage128. The x86emu
> version
> runs, but doesn't reset the adapter.
> 
> I had tried hacking this code out of X86 without
> success. I also tried moding lrmi. lrmi needs more
> of
> the bios vectors, entry points, etc set up.
> 
> There are later versions of x86emu here
> ftp://ftp.scitechsoft.com/devel/x86emu but I can get
> them to build. 
> 
> On a related note, in redhat-config-xfree86 the
> probe
> monitor button is always disabled on the secondary
> adapter. This is because redhat-config-xfree86 uses
> ddcprobe to do the configing. ddcprobe uses lrmi
> which
> can't handle a secondary adapter.
> 
> The code in vbios.vm86 could probably be merged into
> ddcprobe/lrmi to make it work. Then it would be easy
> to give ddcprobe a reset parameter too.
> 
> =====
> Jon Smirl
> jonsmirl@yahoo.com
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up
> now.
> http://mailplus.yahoo.com
> 


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
