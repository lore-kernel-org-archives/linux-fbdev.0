From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 26 Jul 2014 10:19:17 +0000
Subject: Re: [PATCH v2] video: fbdev: uvesafb.c: Added additional error checking
Message-Id: <CAFo99gYv1h-J11836Rt=OycJ+cQ_aa4KTf6sVjQKpnCyNsZQUw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1406150427-26077-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <20140724173613.GA2203@udknight>
In-Reply-To: <20140724173613.GA2203@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wang YanQing <udknight@gmail.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, David Fries <David@fries.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

2014-07-24 19:36 GMT+02:00 Wang YanQing <udknight@gmail.com>:
> On Wed, Jul 23, 2014 at 11:20:27PM +0200, Rickard Strandqvist wrote:
>> Variable was assigned a value that is never used.
>> Now the variable is used, and the function returns if a call to
>> uvesafb_exec() returns a error.
>
> Because the only user of uvesafb_vbe_getpmi in uvesafb.c
> don't check its return value, it should do the check indeed,
> so maybe below change is better:
>
> -       if ((task->t.regs.eax & 0xffff) != 0x4f || task->t.regs.es < 0xc000) {
> +       if (err || (task->t.regs.eax & 0xffff) != 0x4f || task->t.regs.es < 0xc000) {
>                 par->pmi_setpal = par->ypan = 0;
>         }
>
> Or we check uvesafb_vbe_getpmi's return value, then the code will looks like below:
>
> if (uvesafb_vbe_getpmi(task, par))
>     par->pmi_setpal = par->ypan = 0;


Hi

Sure, I saw that much of the other code using something like:
if (err || ...)


But this whole discussion start with that you wished it would return
the error, and then error code I assumed?

Ok, but something like this then?

err = uvesafb_exec(task);
if (err) {
  par->pmi_setpal = par->ypan = 0;
  return err;
}


Kind regards
Rickard Strandqvist
