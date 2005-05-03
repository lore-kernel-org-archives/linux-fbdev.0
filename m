From: maximilian attems <debian@sternwelten.at>
Subject: Bug#307459: kernel-image-2.6.11-1-686: tridentfb fails to set correct resolution at boot
Date: Tue, 3 May 2005 12:28:42 +0200
Message-ID: <20050503102842.GB19770@sputnik.stro.at>
References: <20050503094246.7370854DD9@localhost.localdomain>
Reply-To: maximilian attems <debian@sternwelten.at>,
	307459@bugs.debian.org
Mime-Version: 1.0
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.307459.B307459.1115116168708@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20050503094246.7370854DD9@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-kernel/>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Marco Presi (Zufus)" <zufus@debian.org>, 307459@bugs.debian.org

could you take a look please at belows bug report,
regarding tridentfb.

from a quick look at the bk-commit-list i didn't
see a patch that could have fixed that inbetween since 2.6.11,
bu of course i may be wrong.  thanks for your feedback.

On Tue, 03 May 2005, Marco Presi (Zufus) wrote:

> Package: kernel-image-2.6.11-1-686
> Version: 2.6.11-3
> Severity: normal
> 
> Hi, 
> 
>     according to documentation shipped with kernel sources
>     (kernel-sources-.../Documentation/fb/tridentfb.txt), it should be
>     possible to set virtual consoles resolution using tridentfb driver.
> 
>     I used this (and many other) parameters:
> 
>     video=tridentfb:1024x768,bpp=16
> 
>     The tridentfb is loaded, during the boot, but the resolution is
>     always set to 640x480 and the screen is broken.
> 
>     Launching 
> 
>     "fbset 1024x768-60"
> 
>     after login, solves the problem. However, the switch "-a" of fbset
>     seems not to work.
> 
>     I tried this on a laptop with a Trident CyberBlade XPA1i.
> 
>     dmesg related output is:
> 
>     tridentfb: framebuffer size = 16384 Kb
>     tridentfb: 0000:01:00.0 board found
>     tridentfb: 1024x768 flat panel found
>     tridentfb: fb0: Trident frame buffer device 640x480-8bpp
>     Console: switching to colour frame buffer device 80x30
> 
> 
>     Ciao Ciao
> 
>     Marco
> 
> 
> -- System Information:
> Debian Release: 3.1
>   APT prefers testing
>   APT policy: (990, 'testing'), (500, 'unstable')
> Architecture: i386 (i686)
> Kernel: Linux 2.6.11-1-686
> Locale: LANG=it_IT@euro, LC_CTYPE=it_IT@euro (charmap=ISO-8859-15) (ignored: LC_ALL set to it_IT@euro)
> 
> Versions of packages kernel-image-2.6.11-1-686 depends on:
> ii  coreutils [fileutils]         5.2.1-2    The GNU core utilities
> ii  initrd-tools                  0.1.78     tools to create initrd image for p
> ii  module-init-tools             3.2-pre1-2 tools for managing Linux kernel mo
> 
> -- no debconf information
> 
> 
--
maks
