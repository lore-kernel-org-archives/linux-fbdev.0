From: Wang YanQing <udknight@gmail.com>
Date: Thu, 24 Jul 2014 17:36:13 +0000
Subject: Re: [PATCH v2] video: fbdev: uvesafb.c:  Added additional error checking
Message-Id: <20140724173613.GA2203@udknight>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1406150427-26077-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1406150427-26077-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, David Fries <David@Fries.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, pavel@ucw.cz

On Wed, Jul 23, 2014 at 11:20:27PM +0200, Rickard Strandqvist wrote:
> Variable was assigned a value that is never used.
> Now the variable is used, and the function returns if a call to
> uvesafb_exec() returns a error.

Because the only user of uvesafb_vbe_getpmi in uvesafb.c
don't check its return value, it should do the check indeed,
so maybe below change is better:

-       if ((task->t.regs.eax & 0xffff) != 0x4f || task->t.regs.es < 0xc000) {
+       if (err || (task->t.regs.eax & 0xffff) != 0x4f || task->t.regs.es < 0xc000) {
                par->pmi_setpal = par->ypan = 0;
        }

Or we check uvesafb_vbe_getpmi's return value, then the code will looks like below:

if (uvesafb_vbe_getpmi(task, par))
    par->pmi_setpal = par->ypan = 0;


Add cc:pavel@ucw.cz, you should cc all the people who replied your patch 
in later patch version.

Thanks.
