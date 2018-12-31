From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 31 Dec 2018 12:29:46 +0000
Subject: Re: [PATCH v8 20/25] powerpc, fbdev: Use arch_nvram_ops methods instead of nvram_read_byte() and nvr
Message-Id: <CAK8P3a3645im4aFDi2mNjwcCe=jvmDLkKK_ZSwG1POOLUq=+QQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <7e8eb87ea829c03941c895c968df2ebd0f80512f.1545784679.git.fthain@telegraphics.com.au>
 <20181229180236.Horde.idY3gOIzkSWywjIrqlXJMA1@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812301024400.215@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812301024400.215@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Finn Thain <fthain@telegraphics.com.au>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Ellerman <mpe@ellerman.id.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Sun, Dec 30, 2018 at 12:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:

>
> Is there some benefit, or is that just personal taste?
>
> Avoiding changes to call sites avoids code review, but I think 1) the
> thinkpad_acpi changes have already been reviewed and 2) the fbdev changes
> need review anyway.
>
> Your suggesion would add several new entities and one extra layer of
> indirection.
>
> I think indirection harms readability because now the reader now has to go
> and look up the meaning of the new entities.
>
> It's not the case that we need to choose between definitions of
> nvram_read_byte() at compile time, or stub them out:
>
> #ifdef CONFIG_FOO
> static inline unsigned char nvram_read_byte(int addr)
> {
>         return arch_nvram_ops.read_byte(addr);
> }
> #else
> static inline unsigned char nvram_read_byte(int addr) { }
> #endif
>
> And I don't anticipate a need for a macro here either:
>
> #define nvram_read_byte(a) random_nvram_read_byte_impl(a)
>
> I think I've used the simplest solution.

Having the indirection would help if the inline function can
encapsulate the NULL pointer check, like

static inline unsigned char nvram_read_byte(loff_t addr)
{
       char data;

       if (!IS_ENABLED(CONFIG_NVRAM))
                 return 0xff;

       if (arch_nvram_ops.read_byte)
                 return arch_nvram_ops.read_byte(addr);

       if (arch_nvram_ops.read)
                 return arch_nvram_ops.read(char, 1, &addr);

      return 0xff;
}

(the above assumes no #ifdef in the structure definition, if you
keep the #ifdef there they have to be added here as well).

      Arnd
