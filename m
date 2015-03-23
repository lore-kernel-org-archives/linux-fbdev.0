From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 23 Mar 2015 13:55:11 +0000
Subject: Re: [PATCH RESEND 2 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150323133048.GA27897@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150323105323.GA10964@mwanda>
 <CAA5enKaPnRBT=8Tkx7rm6GQYXMvA=pwxmRYpnkRU8uHok8ypUg@mail.gmail.com>
 <20150323115129.GI10964@mwanda>
 <CAA5enKZ0gLUPmhWrC5-WOqF2E9v43x9uvEEy-J_we9-Ty=SUPw@mail.gmail.com>
 <20150323125513.GB8151@sudip-PC>
 <CAA5enKbKJm2QeH+rbXB+NKw7+O=eXN-01ifLUZPupJ9BF3q+fQ@mail.gmail.com>
 <20150323131422.GE8151@sudip-PC>
 <CAA5enKaj78eY9vG=7vGhBb_=EpwV6yyKKMjNCUY7BuJvDDvpgg@mail.gmail.com>
 <CAA5enKYLYiMHS3ZNX-9=17VB1zp0z8bgVRxOKgCE12KgCBGYfw@mail.gmail.com>
 <CAA5enKYeq8id8s+w+AA1e0haZci9ZEXj+3VSPdm_=Uy7vbHOFQ@mail.gmail.com>
In-Reply-To: <CAA5enKYeq8id8s+w+AA1e0haZci9ZEXj+3VSPdm_=Uy7vbHOFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

On Mon, Mar 23, 2015 at 01:25:37PM +0000, Lorenzo Stoakes wrote:
> On 23 March 2015 at 13:21, Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> > Sigh. Checking the emails I actually sent, I seem to *somehow* have
> > sent old files in this resend :S I really don't know how this
> > happened. My copies of the patches all apply perfectly correctly, but
> > these are not the ones I sent.
> 
> And just to add to my embarrassment, this is actually *not* the case,
> they DO all apply, gmail mangled the patches. So they seem fine after
> all!
> 
> Sudip - could you try to carefully grab each of the 5 patches with
> [RESEND 2] in the subject to make sure you are applying them
> correctly?
my apologies. they are applying properly. i had them already applied
for testing that hardware change, and again i tried to apply them.
sorry for the confusion. :(

regards
sudip
> 
> Best,
> 
> -- 
> Lorenzo Stoakes
> https:/ljs.io
