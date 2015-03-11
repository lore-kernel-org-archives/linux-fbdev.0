From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 11 Mar 2015 10:41:46 +0000
Subject: Re: [PATCH 1/6] staging: sm750fb: Use memset_io instead of memset
Message-Id: <CAA5enKYwwHTFJ0dT0P_4w5YimW96KvAsz1zGD1VRAsJ5a-6=Rw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
	<20150311085433.GU10964@mwanda>
	<CAA5enKaWynLvLUN+GCdphOOMmqX+cAj3kA3owjKbng66CK=pqg@mail.gmail.com>
	<20150311094806.GE4560@sudip-PC>
	<20150311103542.GF4560@sudip-PC>
In-Reply-To: <20150311103542.GF4560@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 11 March 2015 at 10:35, Sudip Mukherjee
> i think i will better check v2 of your series on hardware

This is incoming in just a moment (though I only v2 patches in the
series I've changed which I think is the right way to make
modifications with a patch series.)

> , and while
> you are preparing that v2 keep in mind the changelog should not exceed
> 72 characters. in your this series for all patches it was more than
> that.

I will update the messages in the changed patches accordingly, I'm not
sure this is worth a resend of all previous patches for however? I do
see quite a few patches in the log that exceed this.

Additionally, I suspect it would make the patches less readable to
wrap sparse warning lines so I think those ought to sit outside of
this limit.

I am more than happy to change these though if these ought to be kept
*strictly* to a 72 character limit throughout?

Best,

-- 
Lorenzo Stoakes
https:/ljs.io
