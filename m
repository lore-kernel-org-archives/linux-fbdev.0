From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:36:49 +0000
Subject: Re: [PATCH v4] video: fbdev: ssd1307fb: Added support to Column offset
Message-Id: <2f18ec01-6041-d3f2-787e-16490faf2fbe@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1595622138-3965-1-git-send-email-455.rodrigo.alencar@gmail.com>
 <CGME20200727204022eucas1p2e9b7da30fb7157d3d6802833c0625e5d@eucas1p2.samsung.com>
 <20200727204016.GA836415@bogus>
In-Reply-To: <20200727204016.GA836415@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


[ added dri-devel ML to Cc: ]

On 7/27/20 10:40 PM, Rob Herring wrote:
> On Fri, 24 Jul 2020 17:22:18 -0300, Rodrigo Alencar wrote:
>> This patch provides support for displays like VGM128064B0W10,
>> which requires a column offset of 2, i.e., its segments starts
>> in SEG2 and ends in SEG129.
>>
>> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/display/ssd1307fb.txt | 1 +
>>  drivers/video/fbdev/ssd1307fb.c                         | 8 ++++++--
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to drm-misc-next tree, thanks and sorry for the delay.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
