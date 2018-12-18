From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 18 Dec 2018 13:46:41 +0000
Subject: Re: [PATCH v2 -next] staging: fbtft: use strcmp() instead of strncmp() for
Message-Id: <139ad344-095c-c754-bd17-782e4ede958d@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181218132508.18672-1-yuehaibing@huawei.com>
 <20181218133747.GG15451@kadam>
In-Reply-To: <20181218133747.GG15451@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org, leobras.c@gmail.co, radek.dostal@streamunlimited.co, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On 2018/12/18 21:37, Dan Carpenter wrote:
> On Tue, Dec 18, 2018 at 09:25:08PM +0800, YueHaibing wrote:
>> strncmp() stops comparing when either the end of one of the first two 
>> arguments is reached or when 'n' characters have been compared, whichever
>> comes first.That means that strncmp(s1, s2, n) is equivalent to 
>> strcmp(s1, s2) if n exceeds the length of s1 or the length of s2.
>>
>> This patch avoids that the following warning is reported by smatch:
>>
>> drivers/staging/fbtft/fbtft_device.c:1458
>>  fbtft_device_init() error: strncmp() '"list"' too small (5 vs 32)
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v2: fix patch title
> 
> v2 is worse than v1...

Yes, ...., I messed up.

I will fix it.

> 
> v1 is a little long but I wouldn't have complained about it.
> 
> Please assume that the subject and the commit message are separate
> things.  Take a look how the patch description reads on marc.info:
> 
> https://marc.info/?l=linux-driver-devel&m4513957719226&w=2
> 
> regards,
> dan carpenter
> 
> 
> .
> 
