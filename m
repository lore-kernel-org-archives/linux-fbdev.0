From: Archit Taneja <a0393947@ti.com>
Date: Mon, 09 Jul 2012 07:59:40 +0000
Subject: Re: [PATCH 0/2] OMAPDSS: PM runtime fixes for 3.5-rc
Message-Id: <4FFA8C9C.2080303@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341405829-16964-1-git-send-email-archit@ti.com> <4FFA0549.9020802@gmx.de>
In-Reply-To: <4FFA0549.9020802@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: tomi.valkeinen@ti.com, jaswinder.singh@linaro.org, jw@terrafix.co.uk, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Hi Florian,

On Monday 09 July 2012 03:40 AM, Florian Tobias Schandinat wrote:
> Hi Archit,
>
> On 07/04/2012 12:43 PM, Archit Taneja wrote:
>> Hi Florian,
>>
>> These are 2 fixes which Tomi had intended to push for the coming rcs. He is
>> currently on vacation and asked me to post the patches on his behalf.
>>
>> The first patch ensures that system suspend doesn't break on OMAP if DSS is
>> enabled. The second patch prevents some warning backtraces when the kernel is
>> not built with PM runtime.
>>
>> Could you please queue these for the upcoming rc?
>
> as you sent me those patches you should have added your Signed-off-by as
> well, I added it.
> Also the first patch of this series contained 2 coding style issues
> related to braces that checkpatch complained about and also differed
> from the coding style used in those files, I fixed those as well.
> I applied both patches.
>

Thanks for the fixes and the pull. I'll be more careful the next time.

Thanks,
Archit
