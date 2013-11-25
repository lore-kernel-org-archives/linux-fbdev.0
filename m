From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Nov 2013 20:46:04 +0000
Subject: Re: randconfig build error in next-20131125, in drivers/video/kyro
Message-Id: <CAMuHMdXGXKUHw8jVrn-_n0Y9QPaWA5hQ9Mim+W1t+-LGezuh3A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+r1Zhh83TzjeJJWqtBADD807FYw-LPdq4nzyoE5xN2mf9Hniw@mail.gmail.com>
In-Reply-To: <CA+r1Zhh83TzjeJJWqtBADD807FYw-LPdq4nzyoE5xN2mf9Hniw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jim Davis <jim.epost@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Mon, Nov 25, 2013 at 8:49 PM, Jim Davis <jim.epost@gmail.com> wrote:
> /home/jim/linux/arch/x86/include/asm/uaccess.h: In function ‘kyrofb_ioctl’:
> /home/jim/linux/arch/x86/include/asm/uaccess.h:633: error: call to
> ‘copy_to_user_overflow’ declared with attribute error: copy_to_user()
> buffer size is too small

Cool!

        case KYRO_IOCTL_UVSTRIDE:
                if (copy_to_user(argp, &deviceInfo.ulOverlayUVStride,
sizeof(unsigned long)))

ulOverlayUVStride is u32, while unsigned long is 8 bytes on 64 bit.

I guess it should use "sizeof(u32)", or better
"sizeof(deviceInfo.ulOverlayUVStride)"
instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
