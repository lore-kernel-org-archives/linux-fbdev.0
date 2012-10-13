From: Alexander Holler <holler@ahsoftware.de>
Date: Sat, 13 Oct 2012 11:44:31 +0000
Subject: Re: [PATCH RESEND] video/udlfb: fix line counting in fb_write
Message-Id: <5079541F.5060308@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5029FA0D.1090107@ahsoftware.de> <50756A21.1020700@gmx.de>
In-Reply-To: <50756A21.1020700@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org

Am 10.10.2012 14:29, schrieb Florian Tobias Schandinat:
> On 08/14/2012 07:11 AM, Alexander Holler wrote:
>> Line 0 and 1 were both written to line 0 (on the display) and all
>> subsequent
>> lines had an offset of -1. The result was that the last line on the display
>> was never overwritten by writes to /dev/fbN.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> 
> As Bernie agreed but didn't send me a pull request, I applied this one.

Thanks a lot.

> Though the formatting was screwed up and I had to fix it...

Sorry, must have happened because I've used "Edit as new" in Thunderbird
to resend the patch while just adding the RESEND to the subject.

Good to know.

Thanks,

Alexander

