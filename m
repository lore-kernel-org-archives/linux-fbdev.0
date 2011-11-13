From: Anatolij Gustschin <agust@denx.de>
Date: Sun, 13 Nov 2011 20:53:00 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <20111113215300.026b3dc7@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello David,

On Sun, 13 Nov 2011 19:10:59 -0500 (EST)
David J Ring Jr <n1ea@arrl.net> wrote:

> Hello Anatolij,
> 
> And when I reboot /dev/fb0 disappears again.

Yes, this is expected since there is no frame buffer
driver loaded in your system.

> What is very strange to me is that when I run links2 -g the error message 
> says that /dev/fb0 does not exist, while if I list the file it says that 
> it is there ls /dev/fb0 says the file is there.

I'll try to explain my understanding of the issue.
The device node file /dev/fb0 is only an interface to the frame
buffer driver. It can be created by the kernel automatically if
there is a graphic chip in the system and the appropriate frame
buffer driver is loaded and some device filesystem is initialized
and mounted, e.g. devtmpfs device filesystem.

Or /dev/fb0 can be created by the user, but if it has been created
by the user and there is no frame buffer driver running, then the
driver interface cannot be opened since no corresponding driver
responds when an application tries to open the device. This is
the error message that you currently see.

When you create the device node file under /dev at runtime, it will
disappear when rebooting, since the device file system under /dev
will be unmounted. Even if there is a /dev directory on your hard
disk with some existing device nodes, e.g. fb0 existing, there
is still a possibility that you won't see these nodes at runtime.
If the kernel creates device system at runtime and it is mounted
under /dev, the content of this device system will be populated
with device nodes for registered devices. When there is no frame
buffer driver loaded, no fb0 device will be registered, no device
node will be created.

Hope this helps,

Anatolij
