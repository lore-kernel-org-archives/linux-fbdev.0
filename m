From: Ran Shalit <ranshalit@gmail.com>
Date: Sat, 05 Dec 2015 10:45:46 +0000
Subject: Re: wipe framebuffer with dd command
Message-Id: <CAJ2oMhL9AMcM_DPRoHXC-jWB+9sKoOd+Dngab_JfEj-y3YvXwA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAJ2oMhJ3scGVqVCzaseCgcUTFhtpJ0bMPy9QxASVUTib98eDCw@mail.gmail.com>
In-Reply-To: <CAJ2oMhJ3scGVqVCzaseCgcUTFhtpJ0bMPy9QxASVUTib98eDCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernelnewbies@lists.kernelnewbies.org

On Sat, Dec 5, 2015 at 8:03 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> Hello,
>
> I would like to ask what is the effect of wiping frame buffer (dd
> if=/dev/zero of=/dev/fb0) ?
> I have some issue with framebuffer timing on LCD 240x320.
> I could not find a timing with width$0, height20 which result in
> stable picture, but
> the following timing gave me stable ppicture with LCD:
>
> Pixel clocke00
>
> Width$0
> HeightQ2  <<------------- instead of 320 !!
> Hfp=1
> Hbp0
> HSW
> Vfp=1
> Vbp=1
> VSW
>
> The only strange thing is that I had to use height 512 instead of 320.
> When I try to render image it is stable but it starts in different
> line every time.
> And here comes the important part:
> After doing:
>
>      dd if=/dev/zero of=/dev/fb0
>
> It resolved the issue , and a new image starts from line 0.
>
> I don't understand why.
> Does anyone have any idea ?
> Do you think I still have a timing problem with LCD ?
>
> Regards,
> Ran


Hi,

I wanted to add that framebuffer is configured as following:

fbset -fb /dev/fb0 -xres 240 -yres 320 -vxres 240 -vyres 320

so, I don't know why

dd if=/dev/zero of=/dev/fb0

results in image correct display starting with line 0 on the screen.

I think that writing the image to framebuffer should have filled the
complete buffer.

Regards,

Ran
