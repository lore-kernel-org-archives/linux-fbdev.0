From: Anatolij Gustschin <agust@denx.de>
Date: Sun, 13 Nov 2011 20:11:18 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <20111113211118.7aa82d34@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, 13 Nov 2011 18:57:26 -0500 (EST)
David J Ring Jr <n1ea@arrl.net> wrote:

> Hello Anatolij,
> 
> Nice to hear from you and thank you for your suggestions.
> 
> I did what you said and now I have a /dev/fb0 with permissions
> 
> ls /dev/fb0 -alsh
> 
> 0 crw-rw---- 1 root video 29, 0 Nov 13 18:25 /dev/fb0
> 
> Output of cat /proc/fb
> 
> No output.

The frame buffer driver for your graphic card is not in the
kernel or could not bee initialized properly, so this is one
reason for missing /dev/fb0.

Are kernel modules installed in your system? What is the output
of the command below?

ls -l /lib/modules/`uname -r`/kernel/drivers/video


If you do not know which graphic chip is in your system,
you might want to run

lspci -v | grep VGA

Then you have to install the appropriate frame buffer driver
kernel module or alternatively to build the kernel with frame
buffer driver included.

Anatolij
