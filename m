From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 11 Mar 2015 09:11:52 +0000
Subject: Re: [PATCH 1/6] staging: sm750fb: Use memset_io instead of memset
Message-Id: <CAA5enKaWynLvLUN+GCdphOOMmqX+cAj3kA3owjKbng66CK=pqg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
	<20150311085433.GU10964@mwanda>
In-Reply-To: <20150311085433.GU10964@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 11 March 2015 at 08:54, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> When I see a patch like this, then I worry, "What if the Sparse
> annotations are wrong?  The patch description doesn't say anything about
> that."  After review then I think the annotations are correct so that's
> fine.

How do you mean? I was careful to check what sparse was referring to,
then investigate how memset should be used with pointers with a
__iomem qualifier. I'd like to be able to improve my patch
descriptions going forward as best I can :)

> Btw, do you have this hardware?  Are you able to test these changes?

Unfortunately not, I am trying to keep these changes as simple code
fixes that ought not to affect actual hardware behaviour as I can
(though of course you can never be entirely sure that's the case!)

I suspect that Sudip must have some real hardware, is this the case
Sudip? If it isn't too presumptuous of me to ask, perhaps you might be
able to check patches that are successfully merged into
staging-testing?

Best,

-- 
Lorenzo Stoakes
https:/ljs.io
