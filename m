From: Anatolij Gustschin <agust@denx.de>
Date: Mon, 14 Nov 2011 18:58:56 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <20111114195856.22b471b5@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello David,

On Mon, 14 Nov 2011 01:09:53 -0500 (EST)
David J Ring Jr <n1ea@arrl.net> wrote:

> I found a line in /etc/default/grub which has nomodeset in it and I 
> disabled it.
> 
> Here is what I have in that file now.
> 
> I have a feeling that something in grub is not right.

Did you run 'sudo update-grub' command after changing the /etc/default/grub
file ? If not, then the actual grub configuration file was not
updated and you probably still have nomodeset on the kernel command
line.

> # If you change this file, run 'update-grub' afterwards to update
> # /boot/grub/grub.cfg.
> 
> GRUB_DEFAULT=0
> GRUB_TIMEOUT=5
> GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
> #GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"
> GRUB_CMDLINE_LINUX=""
...
> What do you think?  Is this where nomodeset is and does it look like this 
> should work?  I still cannot get /dev/fb0

It should work. If you additionally run 'sudo update-grub', the grub
configuration file /boot/grub/grub.cfg will be updated. Then nomodeset
shouldn't be passed on the kernel command line any more.

Anatolij
