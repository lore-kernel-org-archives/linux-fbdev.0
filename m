From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Wed, 26 Jun 2013 11:57:16 +0000
Subject: Re: [PATCH 2/2] video:da8xx-fb: Convert to devm_* api
Message-Id: <CA+V-a8uhK5-QJKifkiSUN6Nz0aBc2moraWQUJPCmZg9zaFX0eg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1368688257-18705-1-git-send-email-prabhakar.csengg@gmail.com>
 <1368688257-18705-3-git-send-email-prabhakar.csengg@gmail.com> <51CAD305.30407@ti.com>
In-Reply-To: <51CAD305.30407@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, "Etheridge, Darren" <detheridge@ti.com>
Cc: DLOS <davinci-linux-open-source@linux.davincidsp.com>, LFBDEV <linux-fbdev@vger.kernel.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, LKML <linux-kernel@vger.kernel.org>

Hi Tomi,

On Wed, Jun 26, 2013 at 5:09 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 16/05/13 10:10, Lad Prabhakar wrote:
>> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>
>> Use devm_ioremap_resource instead of reques_mem_region()/ioremap() and
>> devm_request_irq() instead of request_irq().
>>
>> This ensures more consistent error values and simplifies error paths.
>>
>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>> ---
>>  drivers/video/da8xx-fb.c |   39 +++++++--------------------------------
>>  1 files changed, 7 insertions(+), 32 deletions(-)
>
> There's something similar in Darren's da8xx-fb series. Can you check if
> there are differences?
>
I don't see similar changes in his patch series.

Darren while you are at it you can take this patch along you series.
let me know how you plan to.

Regards,
--Prabhakar Lad
