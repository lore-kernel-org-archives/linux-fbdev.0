From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Wed, 26 Jun 2013 11:32:01 +0000
Subject: Re: [PATCH 2/2] video:da8xx-fb: Convert to devm_* api
Message-Id: <CA+V-a8sqNehbk-_KhhGXtAsLcaO6_p661uBgo=ybP663xXPOMQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1368688257-18705-1-git-send-email-prabhakar.csengg@gmail.com> <1368688257-18705-3-git-send-email-prabhakar.csengg@gmail.com>
In-Reply-To: <1368688257-18705-3-git-send-email-prabhakar.csengg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, DLOS <davinci-linux-open-source@linux.davincidsp.com>, LFBDEV <linux-fbdev@vger.kernel.org>

Hi Tomi/ Florian

On Thu, May 16, 2013 at 12:40 PM, Lad Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>
> Use devm_ioremap_resource instead of reques_mem_region()/ioremap() and
> devm_request_irq() instead of request_irq().
>
> This ensures more consistent error values and simplifies error paths.
>
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> ---

Can you pick up this patch and drop 1/2.

Regards,
--Prabhakar Lad
