From: Anatolij Gustschin <agust@denx.de>
Date: Sun, 13 Nov 2011 21:39:25 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <20111113223925.7be809ec@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, 13 Nov 2011 21:16:52 -0500 (EST)
David J Ring Jr <n1ea@arrl.net> wrote:

> OK so how do I get a frame buffer driver loaded?

Check if some frame buffer drivers are installed
in your system, so e.g. run

ls /lib/modules/`uname -r`/kernel/drivers/video

to see if there are any frame buffer driver modules
installed.

Then you have to select the suitable driver for your
graphic card and load it by running

modprobe drivername

> I don't have any backlisted framebuffer drivers, what is stopping me from 
> loading a frame buffer driver?
>
> Does anyone know what I have to do?


Usually the driver should be loaded automatically if
it is installed. Maybe some error happened while loading
the driver. Dump the kernel log messages by running dmesg
and check if there was an attempt to load the driver for
your graphic card.

Anatolij
