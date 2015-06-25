From: Juston Li <juston.h.li@gmail.com>
Date: Thu, 25 Jun 2015 15:49:30 +0000
Subject: Re: [PATCH v3 16/19] staging: sm750fb: fix brace placement
Message-Id: <CAFow2F_zK42gJ0UoV+GwqLrfsxB2Nqi8kaB7OB+=-APftp=FfQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
	<1435163120-3253-16-git-send-email-juston.h.li@gmail.com>
	<20150625121729.GD13366@sudip-PC>
In-Reply-To: <20150625121729.GD13366@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Jun 25, 2015 at 5:17 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> On Wed, Jun 24, 2015 at 09:25:17AM -0700, Juston Li wrote:
>> Fix brace placement errors caught by checkpatch.pl
>> ERROR: that open brace { should be on the previous line
>>
>> Signed-off-by: Juston Li <juston.h.li@gmail.com>
>> ---
> <snip>
>> @@ -71,14 +66,11 @@ static void setDisplayControl(int ctrl, int dispState)
>>                       POKE32(PANEL_DISPLAY_CTRL, ulDisplayCtrlReg);
>>               }
>>
>> -     }
>>       /* Set the secondary display control */
>> -     else
>> -     {
>> +     } else {
> just a thought. The comment previously was at the beginning of the else
> block, but now it will be placed inside the if block - at the end.
> will it confuse code readers afterwards?
>
> regards
> sudip

I placed it above the else to make it consistent with the if statement with
similar comment that the else corresponds to:

/* Set the primary display control */
- if (!ctrl)+ if (!ctrl) {

Thanks
Juston
