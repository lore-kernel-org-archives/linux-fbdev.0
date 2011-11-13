From: David J Ring Jr <n1ea@arrl.net>
Date: Sun, 13 Nov 2011 18:58:19 +0000
Subject: Re: Getting FB to work in Console
Message-Id: <alpine.DEB.2.00.1111131829410.2535@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
In-Reply-To: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hello Anatolij,

Nice to hear from you and thank you for your suggestions.

I did what you said and now I have a /dev/fb0 with permissions

ls /dev/fb0 -alsh

0 crw-rw---- 1 root video 29, 0 Nov 13 18:25 /dev/fb0

Output of cat /proc/fb

No output.

Output of cat proc/cmdline

BOOT_IMAGE=3D/boot/vmlinuz-2.6.32-5-686 root=3DUUID=CB1268f1-4e20-4409-87b1=
-3d882c14102c ro nomodeset


Output of dmesg | grep vesa

No output.

When I try to run links2 -g now I get these errors:


    ~~~~~~~~~~~~~~~~~~~~~~~~~~| DirectFB 1.2.10 |~~~~~~~~~~~~~~~~~~~~~~~~~~
         (c) 2001-2008  The world wide DirectFB Open Source Community
         (c) 2000-2004  Convergence (integrated media) GmbH
       ----------------------------------------------------------------

(*) DirectFB/Core: Single Application Core. (2010-06-30 18:37)=20
(!) DirectFB/FBDev: Error opening '/dev/fb0'!
     --> No such device
(!) DirectFB/Core: Could not initialize 'system_core' core!
     --> Not supported!


I hope that is helpful.

David


On Sun, 13 Nov 2011, Anatolij Gustschin wrote:


> You have to add write permissions for the group also. Check if
> /dev/fb0 can be accessed if you create it by using
> sudo mknod /dev/fb0 c 29 0 -m 660
> sudo chown :video /dev/fb0
>
> What is the output of following commands on your system?
> cat /proc/fb
> cat /proc/cmdline
> dmesg | grep vesa
>
> Anatolij
>
