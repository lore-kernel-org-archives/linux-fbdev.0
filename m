From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 17 Dec 2009 19:24:12 +0000
Subject: Re: [PATCH 7/9] drivers/video: Correct code taking the size of a
Message-Id: <4B2A855C.8080003@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.0912131242240.24267@ask.diku.dk>	<4B24E3AB.9040609@gmx.de> <20091213114343.a60828d3.akpm@linux-foundation.org>
In-Reply-To: <20091213114343.a60828d3.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Julia Lawall <julia@diku.dk>, JosephChan@via.com.tw, Scott Fang <ScottFang@viatech.com.cn>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Andrew,

thanks for your comment (and for taking the patch).
You can count it as Acked-by:me as it is technically correct. I also 
tested it but as I don't know any program that uses this interface (and 
not wanting to write my own as I do not want to encourage anyone to use 
this interface) I can't say whether it now works as intended.
However this patch is certainly a step in the right direction as writing 
random numbers to hardware is rarely correct :-)

Andrew Morton schrieb:
> On Sun, 13 Dec 2009 13:52:59 +0100 Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
>> Hi Julia, Andrew,
>>
>> Julia Lawall schrieb:
>>> From: Julia Lawall <julia@diku.dk>
>>>
>>> sizeof(viafb_gamma_table) is just the size of the pointer.  This is changed
>>> to the size used when calling kmalloc to initialize the pointer.
>> this is the second patch addressing this issue ending up in my mailbox. 
>> At least this one is technically correct so feel free to upstream it.
>> However I vote for removing this ioctl hell from viafb as most of them 
>> duplicate framebuffer functionality or have unknown (not clearly 
>> defined) functionality or at least solve a generic problem with a custom 
>> ioctl (which I consider bad). I had a patch ready to move this stuff to 
>> an extra file and print a warning that it is subject to be removed. I 
>> feel a bit uncomfortable about repairing broken stuff prior to removing it.
>> Any comments on this subject?
>>
> 
> I favour both repairing and removing broken stuff ;)
> 
> We may as well fix it if problems are known.  Perhaps someone is
> hitting the problem at runtime in an older kernel and needs a patch to
> backport.  Perhaps we later decide to revert the removal, thus
> reinstating the known bug.

You are right.
I'll try to send a patch that at least labels these ioctls 
unstable/depreciated as soon as time permits so that nobody will start 
using them.


Regards,

Florian Tobias Schandinat
