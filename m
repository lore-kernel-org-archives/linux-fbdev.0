From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 29 Sep 2012 07:37:29 +0000
Subject: Re: [PATCH] fb: only enable console lock in fb for VGA console
Message-Id: <CAMuHMdXsX+CwcAM_KOOtu-Q8ueD8bYHJ6uNwF1eYeJ3=D3TMVA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAGA24M+PmObK3ZJWvtNhBzxO4WkGk_xyveQiZNtZe7xGdHrbFw@mail.gmail.com>
In-Reply-To: <CAGA24M+PmObK3ZJWvtNhBzxO4WkGk_xyveQiZNtZe7xGdHrbFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Sep 29, 2012 at 7:29 AM, Jun Nie <niej0001@gmail.com> wrote:
> If VGA console is not enable, we do not have to
     ^^^
Frame buffer console?

> involve console lock/unlock in FB framework to avoid

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
