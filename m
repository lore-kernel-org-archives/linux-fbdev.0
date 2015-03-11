From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 11 Mar 2015 10:47:42 +0000
Subject: Re: [PATCH 1/6] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150311103542.GF4560@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
 <20150311085433.GU10964@mwanda>
 <CAA5enKaWynLvLUN+GCdphOOMmqX+cAj3kA3owjKbng66CK=pqg@mail.gmail.com>
 <20150311094806.GE4560@sudip-PC>
In-Reply-To: <20150311094806.GE4560@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 03:18:06PM +0530, Sudip Mukherjee wrote:
> On Wed, Mar 11, 2015 at 09:11:52AM +0000, Lorenzo Stoakes wrote:
> > On 11 March 2015 at 08:54, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > Btw, do you have this hardware?  Are you able to test these changes?
> > 
> > Unfortunately not, I am trying to keep these changes as simple code
> > fixes that ought not to affect actual hardware behaviour as I can
> > (though of course you can never be entirely sure that's the case!)
> > 
> > I suspect that Sudip must have some real hardware, is this the case
> > Sudip? If it isn't too presumptuous of me to ask, perhaps you might be
> > able to check patches that are successfully merged into
> > staging-testing?
> yes, i have the hardware and will test on it. but your patch 5/6 and
> 6/6 is scaring me :)

i think i will better check v2 of your series on hardware, and while
you are preparing that v2 keep in mind the changelog should not exceed
72 characters. in your this series for all patches it was more than
that.

regards
sudip

> 
> regards
> sudip
> > 
> > Best,
> > 
> > -- 
> > Lorenzo Stoakes
> > https:/ljs.io
