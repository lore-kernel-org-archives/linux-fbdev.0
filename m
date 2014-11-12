From: Belisko Marek <marek.belisko@gmail.com>
Date: Wed, 12 Nov 2014 14:04:41 +0000
Subject: Re: [PATCH 1/4] video: omapdss: Add opa362 driver
Message-Id: <CAAfyv34dZBrss5cQJKq=gYUuYb3i7c2cKOyw_QezEuaG3UsodQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-2-git-send-email-marek@goldelico.com>
 <54636763.10605@ti.com>
In-Reply-To: <54636763.10605@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Tomi,

On Wed, Nov 12, 2014 at 2:57 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
>
> On 03/11/14 23:59, Marek Belisko wrote:
>> opa362 is amplifier for videoand can be connected to the tvout pads
>> of the OMAP3. It has one gpio control for enable/disable of the output
>> (high impedance).
>>
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>>  drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
>>  drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
>>  .../fbdev/omap2/displays-new/amplifier-opa362.c    | 347 +++++++++++++++++++++
>>  3 files changed, 354 insertions(+)
>>  create mode 100644 drivers/video/fbdev/omap2/displays-new/amplifier-opa362.c
>
> This doesn't even compile:
>
> drivers/video/fbdev/omap2/displays-new/amplifier-opa362.c:207:28: error:
> dereferencing pointer to incomplete type
>   ddata->enable_gpio = pdata->enable_gpio;
Hmm sorry about that. I must mixed something up. I'll post updated version soon.
Thanks for review.
>
> And it seems to have fields for bypass and bypass which are handled in
> the devconf1 patch.
>
>  Tomi
>
>

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
