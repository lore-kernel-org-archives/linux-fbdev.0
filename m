From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2020 20:59:46 +0000
Subject: Re: [PATCH 1/3] video: fbdev: ssd1307fb: Added support to Column offset
Message-Id: <CAHp75VfLMUCpDWr4_Wo3Gqd4rZdC3dEFhQfmwjF6eTxaLMxYvw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "maxime.ripard" <maxime.ripard@free-electrons.com>, alencar.fmce@imbel.gov.br

On Tue, May 12, 2020 at 11:55 PM Rodrigo Rolim Mendes de Alencar
<455.rodrigo.alencar@gmail.com> wrote:
>
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.

Thank you!

>         if (of_property_read_u32(node, "solomon,page-offset", &par->page_offset))
>                 par->page_offset = 1;
>
> +       if (of_property_read_u32(node, "solomon,col-offset", &par->col_offset))
> +               par->col_offset = 0;
> +
>         if (of_property_read_u32(node, "solomon,com-offset", &par->com_offset))
>                 par->com_offset = 0;

Needs to be rebased on top of latest changes (can be, in particular,
found in Linux Next tree).

-- 
With Best Regards,
Andy Shevchenko
