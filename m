From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:36:27 +0000
Subject: Re: [PATCH 1/1] fbmem: add margin check to fb_check_caps()
Message-Id: <782b4c4d-b428-aa09-2757-d6243a4b174a@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1594149963-13801-1-git-send-email-george.kennedy@oracle.com>
 <CGME20200707194728eucas1p1d1f4239143f36967f86c4593604fb47f@eucas1p1.samsung.com>
 <20200707194714.GA2571@kadam>
In-Reply-To: <20200707194714.GA2571@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>, George Kennedy <george.kennedy@oracle.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, dhaval.giani@oracle.com


[ added dri-devel ML to Cc: ]

On 7/7/20 9:47 PM, Dan Carpenter wrote:
> On Tue, Jul 07, 2020 at 03:26:03PM -0400, George Kennedy wrote:
>> A fb_ioctl() FBIOPUT_VSCREENINFO call with invalid xres setting
>> or yres setting in struct fb_var_screeninfo will result in a
>> KASAN: vmalloc-out-of-bounds failure in bitfill_aligned() as
>> the margins are being cleared. The margins are cleared in
>> chunks and if the xres setting or yres setting is a value of
>> zero upto the chunk size, the failure will occur.
>>
>> Add a margin check to validate xres and yres settings.
>>
>> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
>> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Suggested-by is perhaps a bit strong.  Let's change that to:
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to drm-misc-next tree, thanks and sorry for the delay.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
