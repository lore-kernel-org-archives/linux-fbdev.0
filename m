From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Date: Fri, 25 Dec 2015 13:29:23 +0000
Subject: Re: [PATCH v2] ARM: OMAPFB: panel-sony-acx565akm: fix missing mutex unlocks
Message-Id: <567D44B3.6090309@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <52C956E9.2030008@gmail.com>
 <1388927585-5640-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <52CFD1ED.7010302@ti.com> <52D1113C.8020807@gmail.com>
 <52D3BE08.9040508@ti.com>
In-Reply-To: <52D3BE08.9040508@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: plagnioj@jcrosoft.com, pali.rohar@gmail.com, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>, Aaro Koskinen <aaro.koskinen@iki.fi>


Hi Tomi,

On 13.01.2014 12:20, Tomi Valkeinen wrote:
> On 2014-01-11 11:39, Ivaylo Dimitrov wrote:
>
>> The patch does not apply cleanly on top of rc7, however I applied it by
>> hand. So far it seems it fixes the issue brought by
>> c37dd677988ca50bc8bc60ab5ab053720583c168, though I didn't test if
>> mutex_lock/mutex_unlock are complementary in every code path (at least
>> not explicitly, I guess maemo is doing it for us anyway :) ).
>
> Ok, thanks.
>
>> So, shall I send a patch incorporating your code changes, or you will do
>> it?
>
> I can handle it.
>
>   Tomi
>
>

I still don't see those fixes in mainline, shall I send a patch?

Ivo
