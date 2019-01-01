From: Finn Thain <fthain@telegraphics.com.au>
Date: Tue, 01 Jan 2019 01:10:11 +0000
Subject: Re: [PATCH v8 20/25] powerpc, fbdev: Use arch_nvram_ops methods instead of nvram_read_byte() and nvr
Message-Id: <alpine.LNX.2.21.1901011154590.574@nippy.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <7e8eb87ea829c03941c895c968df2ebd0f80512f.1545784679.git.fthain@telegraphics.com.au> <20181229180236.Horde.idY3gOIzkSWywjIrqlXJMA1@messagerie.si.c-s.fr> <alpine.LNX.2.21.1812301024400.215@nippy.intranet>
 <CAK8P3a3645im4aFDi2mNjwcCe=jvmDLkKK_ZSwG1POOLUq=+QQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3645im4aFDi2mNjwcCe=jvmDLkKK_ZSwG1POOLUq=+QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Mon, 31 Dec 2018, Arnd Bergmann wrote:

> On Sun, Dec 30, 2018 at 12:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> 
> >
> > Is there some benefit, or is that just personal taste?
> >
> > Avoiding changes to call sites avoids code review, but I think 1) the
> > thinkpad_acpi changes have already been reviewed and 2) the fbdev changes
> > need review anyway.
> >
> > Your suggesion would add several new entities and one extra layer of
> > indirection.
> >
> > I think indirection harms readability because now the reader now has to go
> > and look up the meaning of the new entities.
> >
> > It's not the case that we need to choose between definitions of
> > nvram_read_byte() at compile time, or stub them out:
> >
> > #ifdef CONFIG_FOO
> > static inline unsigned char nvram_read_byte(int addr)
> > {
> >         return arch_nvram_ops.read_byte(addr);
> > }
> > #else
> > static inline unsigned char nvram_read_byte(int addr) { }
> > #endif
> >
> > And I don't anticipate a need for a macro here either:
> >
> > #define nvram_read_byte(a) random_nvram_read_byte_impl(a)
> >
> > I think I've used the simplest solution.
> 
> Having the indirection would help if the inline function can
> encapsulate the NULL pointer check, like
> 
> static inline unsigned char nvram_read_byte(loff_t addr)
> {
>        char data;
> 
>        if (!IS_ENABLED(CONFIG_NVRAM))
>                  return 0xff;
> 
>        if (arch_nvram_ops.read_byte)
>                  return arch_nvram_ops.read_byte(addr);
> 
>        if (arch_nvram_ops.read)
>                  return arch_nvram_ops.read(char, 1, &addr);
> 
>       return 0xff;
> }
> 

The semantics of .read_byte and .read are subtly different. For CONFIG_X86 
and CONFIG_ATARI, .read implies checksum validation and .read_byte does 
not.

In particular, in the thinkpad_acpi case, checksum validation isn't used, 
but in the atari_scsi case, it is.

So I like to see drivers explicitly call the method they want. I didn't 
want to obscure this distinction in a helper.

-- 
