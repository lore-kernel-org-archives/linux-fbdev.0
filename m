From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 02 Mar 2020 15:42:02 +0000
Subject: Re: [PATCH 1/2] video: fbdev: wm8505fb: fix sparse warnings about using incorrect types
Message-Id: <10a975e2-cd2a-24c1-b28d-12ea0808a0dd@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116145653eucas1p2222fb48dd6fe1023a4152e687ec577d5@eucas1p2.samsung.com>
 <567cba81-5fec-4d91-f711-c0bdbfe5b513@samsung.com>
 <20200117185851.GA24722@ravnborg.org>
In-Reply-To: <20200117185851.GA24722@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 1/17/20 7:58 PM, Sam Ravnborg wrote:
> On Thu, Jan 16, 2020 at 03:56:50PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> Use ->screen_buffer instead of ->screen_base to fix sparse warnings.
>>
>> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>>   pointer") for details. ]
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Thanks, patch queued for v5.7.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
