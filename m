From: Keith Whitwell <keith@tungstengraphics.com>
Subject: Re: [Dri-devel] Possible bug: nasty interaction between framebuffer and DRI/DRM
Date: Fri, 31 May 2002 13:09:40 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3CF76804.6060608@tungstengraphics.com>
References: <200205311254.50400.chrish@gmx.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Chris Howells <chrish@gmx.co.uk>
Cc: ajoshi@shell.unixbox.com, linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net

Chris Howells wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> I seem to have discovered a nasty interaction between framebuffer and DRI/DRM 
> in OpenGL applications. I can reproduce this problem in at least Return to 
> Castle Wolfenstein (version 1.1b) and Tux Racer.
> 
> I am using a 32 MB ATI Rage Pro 128 on Debian woody (XFree86 4.1). If I run 
> Tuxracer or RTCW, and wait for the game to load, everything is alright. 
> However if I switch to a spare virtual terminal, and switch back to X, the 
> fonts become illegible -- they just appear as coloured boxes with no 
> outlines, making things unplayable.

It sounds like the texture cache is getting wiped out, but the DRI drivers 
aren't realizing that it's happened.  This shouldn't be too hard to fix if 
someone has time.

Keith



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
