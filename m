From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 13 Nov 2011 01:00:05 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <4EBF1695.3080003@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 11/12/2011 11:42 PM, D.J.J. Ring, Jr. wrote:
> I want to make framebuffer work in console only Debian installation.
> I find many of the howto's on the web won't work for current Debian
> Stable - or I'm just too stupid to figure them out.

what graphic card/chip do you have?
You might have to remove the corresponding framebuffer from
/etc/modprobe.d/fbdev-blacklist.conf

> < grin >
> 
> I want to get fbi and links2 -g working in console.
> 
> I tried entering in console:
> 
> sudo mknod /dev/fb0 c 29 0

Shouldn't be necessary. If the correct driver is loaded the device should appear
immediately.


Best regards,

Florian Tobias Schandinat

> 
> But when I reboot /dev/fb0 does not exist.
> 
> I've had links2 -g working before - I've got libdirectfb-dev
> libdirectfb-bin and all the files I can find with directfb to install.
> 
> I am working on Debian Stable command line only.
> 
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

