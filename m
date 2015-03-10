From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Tue, 10 Mar 2015 09:14:55 +0000
Subject: Re: [PATCH] staging: sm750fb: Fix sparse warning
Message-Id: <CAA5enKZDcWV-B1hOt3ffAXA7kxqJq8BrVyzu5DW2vbxDz46ytw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425934628-3717-1-git-send-email-lstoakes@gmail.com>
	<20150310070014.GM10964@mwanda>
	<CAA5enKa5x5R2Z9+Sc4UzKFu+N9rKoh_sW7hfVN8CmmqhF9LMiw@mail.gmail.com>
	<20150310085915.GB16501@mwanda>
In-Reply-To: <20150310085915.GB16501@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 10 March 2015 at 08:59, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The patch is:
>
> [patch] cleanup the type of mmio750
>
> silencing a Sparse warning is just a side benifit of using correct
> data types.  The "one thing per patch" rule also means that you should
> fix a whole problem instead of half a thing per patch.
>
> regards,
> dan carpenter
>

Sure, sorry saw the patch as purely a sparse fixup, will adapt to be
an overall mmio750 cleanup and resubmit!

Best,

-- 
Lorenzo Stoakes
https:/ljs.io
