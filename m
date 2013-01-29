From: Alexander Holler <holler@ahsoftware.de>
Date: Tue, 29 Jan 2013 00:56:01 +0000
Subject: Re: [PATCH 2/3 v2] fb: udlfb: fix hang at disconnect
Message-Id: <51071E21.9030008@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50F2A310.5010006@ahsoftware.de> <1359139768-32294-1-git-send-email-holler@ahsoftware.de> <1359139768-32294-2-git-send-email-holler@ahsoftware.de> <20130128162238.7fba92fe.akpm@linux-foundation.org>
In-Reply-To: <20130128162238.7fba92fe.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bernie Thompson <bernie@plugable.com>, Steve Glendinning <steve.glendinning@shawell.net>, stable@vger.kernel.org

Am 29.01.2013 01:22, schrieb Andrew Morton:
> On Fri, 25 Jan 2013 19:49:27 +0100
> Alexander Holler <holler@ahsoftware.de> wrote:
> 
>> When a device was disconnected the driver may hang at waiting for urbs it never
>> will get. Fix this by using a timeout while waiting for the used semaphore.
>>
>> There is still a memory leak if a timeout happens, but at least the driver
>> now continues his disconnect routine.
>>
>> ...
>>
>> --- a/drivers/video/udlfb.c
>> +++ b/drivers/video/udlfb.c
>> @@ -1832,8 +1832,9 @@ static void dlfb_free_urb_list(struct dlfb_data *dev)
>>  	/* keep waiting and freeing, until we've got 'em all */
>>  	while (count--) {
>>  
>> -		/* Getting interrupted means a leak, but ok at disconnect */
>> -		ret = down_interruptible(&dev->urbs.limit_sem);
>> +		/* Timeout likely occurs at disconnect (resulting in a leak) */
>> +		ret = down_timeout_killable(&dev->urbs.limit_sem,
>> +						FREE_URB_TIMEOUT);
>>  		if (ret)
>>  			break;
> 
> This is rather a hack.  Do you have an understanding of the underlying
> bug?  Why is the driver waiting for things which will never happen?

It is a hack, but I don't want to rewrite the whole driver. There is
already an attempt to do so, udl. The hack is a quick solution which
doesn't make something worse, just better. The only drawback might be
the few additional bytes for the implementation of
down_timeout_killable(), but I thought such should be already available,
and wondered it wasn't.

Fixing the underlying problem (including removing the leaks) would just
end up in another rewrite and I prefer to have a look at udl, maybe
fixing the current problems to use such a device as console there.

I've only posted this small patch series, because some (longterm) stable
kernels don't have udl, and smscufx, which is in large parts identical
to udlfb might want that patch too.

Just in case: I don't know anything about smscufx and have discovered
the similarities between those drivers only when I did a git grep to
search for something I fixed with a previous patch.

Regards,

Alexander
