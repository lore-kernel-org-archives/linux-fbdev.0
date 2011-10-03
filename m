From: Timur Tabi <timur@freescale.com>
Date: Mon, 03 Oct 2011 15:58:43 +0000
Subject: Re: [PATCH 8/9] drivers/video: fsl-diu-fb: merge diu_hw into fsl_diu_data
Message-Id: <4E89DBB3.4060502@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1317244795-24671-8-git-send-email-timur@freescale.com>
In-Reply-To: <1317244795-24671-8-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Florian Tobias Schandinat wrote:
>> > +	struct diu __iomem *diu_reg;
>> > +	spinlock_t reg_lock;
>> > +	unsigned int mode;		/* DIU operation mode */

> Any reason that you added here a new "mode" var that appears to be useless when
> you just deleted the mode variable in patch 7/9?

Thanks for catching that.  That variable should not be there.  I will post a new
patch later today.

-- 
Timur Tabi
Linux kernel developer at Freescale

