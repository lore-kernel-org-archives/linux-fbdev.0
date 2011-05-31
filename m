From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 31 May 2011 03:28:30 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdcfb: Change BGR24 to RGB24
Message-Id: <4DE4605E.6070102@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306400942-26956-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1306400942-26956-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Magnus,
On 2011/05/27 17:14, Magnus Damm wrote:
> Hi Damian,
> 
> On Thu, May 26, 2011 at 6:09 PM, Damian Hobson-Garcia
> <dhobsong@igel.co.jp> wrote:
>> The ordering of the bytes in the 24 bpp RGB colour mode was
>> being set to BGR.
>>
>> This now matches the values returned in the
>> struct fb_var_screeninfo .red, .green, and .blue offsets as well as
>> the output format of other blocs, such as the VEU
>>
>> Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
>> ---
> 
> Thanks for your patch. With this change in place, is the fbdev console
> still working as expected?
> 
> Also, the byte swap settings in _LDDDSR are ok as-is?
Actually, let me look into this a bit more.  After thinking about it
some more there are one or two more things I want to check on this
first.  Please ignore this patch for now.  I'll resubmit it again once
its properly completed. Sorry for the mess.

Thanks,
Damian
