From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Possible bug: nasty interaction between
 framebuffer and DRI/DRM
Date: Fri, 31 May 2002 14:08:21 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0205311407530.1147-100000@vervain.sonytel.be>
References: <200205311254.50400.chrish@gmx.co.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <200205311254.50400.chrish@gmx.co.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Howells <chrish@gmx.co.uk>
Cc: ajoshi@shell.unixbox.com, faith@valinux.com, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net

On Fri, 31 May 2002, Chris Howells wrote:
> I seem to have discovered a nasty interaction between framebuffer and DRI/DRM 
> in OpenGL applications. I can reproduce this problem in at least Return to 
> Castle Wolfenstein (version 1.1b) and Tux Racer.
> 
> I am using a 32 MB ATI Rage Pro 128 on Debian woody (XFree86 4.1). If I run 
> Tuxracer or RTCW, and wait for the game to load, everything is alright. 
> However if I switch to a spare virtual terminal, and switch back to X, the 
> fonts become illegible -- they just appear as coloured boxes with no 
> outlines, making things unplayable.
> 
> The problem does not occur when using software based OpenGL rendering which is 
> why I believe DRI/DRM is involved. This problem only occurs when framebuffer 
> is enabled in the kernel, if framebuffer is disabled the problem disappears, 
> so I believe framebuffer is also at fault.

Do you use `option UseFBDev' in your XF86Config?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
