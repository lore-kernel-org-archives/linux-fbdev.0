From: Anatolij Gustschin <agust@denx.de>
Date: Sun, 13 Nov 2011 16:57:54 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <20111113175754.0c2903f7@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello David,

On Sun, 13 Nov 2011 02:45:17 -0500 (EST)
David J Ring Jr <n1ea@arrl.net> wrote:
...
> Any suggestions?
> 
> I have changed grub to give me a large 640x480 screen and that works but 
> and it gives me color say if I have bash add color to folders and 
> executables - and mc comes up in color but no links2 -g in color because 
> no /dev/fb0.
> 
> Any other suggestions?
> 
> I made my username member of its own group and also tty and video.
> 
> As I said before I tried mknod and that worked but when I rebooted
> /dev/fb0 was gone.
> 
> I tried the mknod command again and it created /dev/fb0
> which is owned by root and in root group.  I changed the group to video.
> 
> Now root has rwx permissions the group can read and everyone can read.

You have to add write permissions for the group also. Check if
/dev/fb0 can be accessed if you create it by using
sudo mknod /dev/fb0 c 29 0 -m 660
sudo chown :video /dev/fb0

> I run links2 -g and it still says it cannot access /dev/fb0.
> 
> If I reboot /dev/fb0 will disappear.
> 
> I'm stuck!

What is the output of following commands on your system?
cat /proc/fb
cat /proc/cmdline
dmesg | grep vesa

Anatolij
