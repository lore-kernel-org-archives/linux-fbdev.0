From: Eric Miao <eric.y.miao@gmail.com>
Date: Tue, 05 Jun 2012 20:54:23 +0000
Subject: Re: [PATCH] mbxfb: unbreak compilation with CONFIG_FB_MBX_DEBUG
Message-Id: <CAMPhdO-s0h7ttnApv4ZE++XeOSfOdwh6n-F1dwOhL0qcpmSTGA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1337013111-7732-1-git-send-email-tartler@cs.fau.de> <4FCE5AD1.6040705@gmx.de>
In-Reply-To: <4FCE5AD1.6040705@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: tartler@cs.fau.de, Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, vamos-dev@lists.cs.fau.de, Reinhard Tartler <siretart@tauware.de>

On Wed, Jun 6, 2012 at 3:15 AM, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> Hi,
>
> On 05/14/2012 04:31 PM, tartler@cs.fau.de wrote:
>> From: Reinhard Tartler <siretart@tauware.de>
>>
>> This patch adds missing function prototypes.
>>
>> Signed-off-by: Reinhard Tartler <tartler@cs.fau.de>
>> ---
>>  drivers/video/mbx/mbxfb.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> This patch was found with tools developed in the VAMOS project:
>> http://www4.cs.fau.de/Research/VAMOS/
>>
>> TBH, I'm not sure if this is the correct solution. However, I'd
>> appreciate if someone could confirm that this is a real bug.
>>
>>
>> diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
>> index 6ce3416..c2200ec 100644
>> --- a/drivers/video/mbx/mbxfb.c
>> +++ b/drivers/video/mbx/mbxfb.c
>> @@ -878,6 +878,9 @@ static int mbxfb_resume(struct platform_device *dev)
>>  #ifndef CONFIG_FB_MBX_DEBUG
>>  #define mbxfb_debugfs_init(x)        do {} while(0)
>>  #define mbxfb_debugfs_remove(x)      do {} while(0)
>> +#else
>> +void mbxfb_debugfs_init(struct fb_info *fbi);
>> +void mbxfb_debugfs_remove(struct fb_info *fbi);
>
> I don't agree. checkpatch complains
> WARNING: externs should be avoided in .c files
> #71: FILE: drivers/video/mbx/mbxfb.c:882:
> +void mbxfb_debugfs_init(struct fb_info *fbi);
>
> And in drivers/video/mbx/mbxdebugfs.c
> static void __devinit mbxfb_debugfs_init(struct fb_info *fbi)
> static void __devexit mbxfb_debugfs_remove(struct fb_info *fbi)
>
> So even if you want to ignore the checkpatch warning (which I could
> understand for just 2 includes even if headers are certainly better)
> you'd have to remove the static at the implementation and for
> consistency include the __devinit/exit in your prototypes.

That actually made a very good point, and I seriously doubt whether the
mbxfb_debugfs_* thing has ever been tested. Instead of making them
public, I see a chance maybe we could remove them completely instead.

>
>>  #endif
>>
>>  #define res_size(_r) (((_r)->end - (_r)->start) + 1)
>
>
> Best regards,
>
> Florian Tobias Schandinat
