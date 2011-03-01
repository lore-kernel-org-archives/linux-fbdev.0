From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Tue, 01 Mar 2011 17:19:54 +0000
Subject: Re: [PATCH 2/6] FBDEV: JZ4740: Initialize jzfb->fb earlier
Message-Id: <4D6D2ABA.2050708@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <80cfeb81c3b4bae96f8ade317a08566c87493578.1298980528.git.mcuelenaere@gmail.com>
In-Reply-To: <80cfeb81c3b4bae96f8ade317a08566c87493578.1298980528.git.mcuelenaere@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Op 01-03-11 14:58, Lars-Peter Clausen schreef:
> On 03/01/2011 01:05 PM, Maurus Cuelenaere wrote:
>> There's no reason to not do this, and this is needed in the upcoming SLCD
>> support patches.
>>
> Is there any specific reason, why this change can't be done in the patch adding
> SLCD support?

I've done this separately because this isn't strictly SLCD-only and thought it
deserved its own commit.
Will merge this.

-- 
Maurus Cuelenaere

