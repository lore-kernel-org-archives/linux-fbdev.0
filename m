From: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>
Date: Tue, 23 Jun 2015 12:30:39 +0000
Subject: Re: [PATCH] staging: sm750fb: convert pr_err to pr_info
Message-Id: <AM3PR06MB129743A910A22D394DB749D6CFA00@AM3PR06MB1297.eurprd06.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150618125052.GA21893@IND12F0122>
In-Reply-To: <20150618125052.GA21893@IND12F0122>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



On Monday 22 June 2015 08:46 PM, Dan Carpenter wrote:
> On Thu, Jun 18, 2015 at 12:56:54PM +0000, Gujulan Elango, Hari Prasath (H.) wrote:
>> From: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
>>
>> This patch modifies few debug prints from pr_err() to pr_info() as they
>> fall under that category.
>>
> 
> They should be dbg or removed.
> 
> regards,
> dan carpenter
> 
> 


Thanks Dan.I shall send a v2 addressing the same.

-- 
thanks & regards,
Hari Prasath
