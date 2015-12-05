From: Ran Shalit <ranshalit@gmail.com>
Date: Sat, 05 Dec 2015 06:03:56 +0000
Subject: wipe framebuffer with dd command
Message-Id: <CAJ2oMhJ3scGVqVCzaseCgcUTFhtpJ0bMPy9QxASVUTib98eDCw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernelnewbies@lists.kernelnewbies.org

Hello,

I would like to ask what is the effect of wiping frame buffer (dd
if=/dev/zero of=/dev/fb0) ?
I have some issue with framebuffer timing on LCD 240x320.
I could not find a timing with width$0, height20 which result in
stable picture, but
the following timing gave me stable ppicture with LCD:

Pixel clocke00

Width$0
HeightQ2  <<------------- instead of 320 !!
Hfp=1
Hbp0
HSW
Vfp=1
Vbp=1
VSW

The only strange thing is that I had to use height 512 instead of 320.
When I try to render image it is stable but it starts in different
line every time.
And here comes the important part:
After doing:

     dd if=/dev/zero of=/dev/fb0

It resolved the issue , and a new image starts from line 0.

I don't understand why.
Does anyone have any idea ?
Do you think I still have a timing problem with LCD ?

Regards,
Ran
