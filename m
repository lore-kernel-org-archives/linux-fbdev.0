From: Sasha Levin <sashal@kernel.org>
Date: Wed, 02 Oct 2019 12:38:41 +0000
Subject: Re: [PATCH v4] video: hyperv: hyperv_fb: Obtain screen resolution from Hyper-V host
Message-Id: <20191002123841.GK17454@sasha-vm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190905091120.16761-1-weh@microsoft.com>
 <DM5PR21MB0137D40DF705CDB372497266D7BB0@DM5PR21MB0137.namprd21.prod.outlook.com>
 <PU1P153MB0169656B3EC48BFCF4D8C134BFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169656B3EC48BFCF4D8C134BFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dexuan Cui <decui@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Wei Hu <weh@microsoft.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Michael Kelley <mikelley@microsoft.com>, Iouri Tarassov <iourit@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, KY Srinivasan <kys@microsoft.com>

On Fri, Sep 13, 2019 at 06:38:42AM +0000, Dexuan Cui wrote:
>> From: Michael Kelley <mikelley@microsoft.com>
>> Sent: Thursday, September 5, 2019 7:06 AM
>>
>> From: Wei Hu <weh@microsoft.com> Sent: Thursday, September 5, 2019 2:12
>> AM
>> >
>> > Beginning from Windows 10 RS5+, VM screen resolution is obtained from
>> host.
>> > The "video=hyperv_fb" boot time option is not needed, but still can be
>> > used to overwrite what the host specifies. The VM resolution on the host
>> > could be set by executing the powershell "set-vmvideo" command.
>> >
>> > Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
>> > Signed-off-by: Wei Hu <weh@microsoft.com>
>> > ---
>> >     v2:
>> >     - Implemented fallback when version negotiation failed.
>> >     - Defined full size for supported_resolution array.
>> >
>> >     v3:
>> >     - Corrected the synthvid major and minor version comparison problem.
>> >
>> >     v4:
>> >     - Changed function name to synthvid_ver_ge().
>> >
>> >  drivers/video/fbdev/hyperv_fb.c | 159
>> +++++++++++++++++++++++++++++---
>> >  1 file changed, 147 insertions(+), 12 deletions(-)
>> >
>>
>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>
>Looks good to me.
>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>

Queued up for hyperv-next, thank you.

--
Thanks,
Sasha
