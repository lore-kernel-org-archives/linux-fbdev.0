From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 26 Jun 2015 04:17:43 +0000
Subject: Re: [PATCH v3 11/19] staging: sm750fb: consistent spacing around operators
Message-Id: <20150626040543.GB3050@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
 <1435163120-3253-11-git-send-email-juston.h.li@gmail.com>
 <20150625115618.GC13366@sudip-PC>
 <CAFow2F9=DhqioyV=tha=KBiTi0pz=Ee+NJJL2up41jUUcF66xg@mail.gmail.com>
In-Reply-To: <CAFow2F9=DhqioyV=tha=KBiTi0pz=Ee+NJJL2up41jUUcF66xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Juston Li <juston.h.li@gmail.com>
Cc: teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Jun 25, 2015 at 09:26:00AM -0700, Juston Li wrote:
> On Thu, Jun 25, 2015 at 4:56 AM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > On Wed, Jun 24, 2015 at 09:25:12AM -0700, Juston Li wrote:
<snip>
> 
> > 2) Considering that you are giving consitent space around operators, then
> >         i think you have missed few operators like '|','&',':' in this
> >         patch.
> >
> 
> These were the only instances the checkpatch.pl error came up. This patch
> only fixes even spacing around a specific operator. Other operators either
> have even or no spacing around them with PATCH 11/19 fixing any operators
> with spacing around required. This leaves operators that checkpatch deems
> spacing as optional which I left as a separate issue to be addressed of making
> optional spacing of operators consistent with each other.

Usually I use the checkpatch which is in linux-next. That will be the
latest version. If you compare, last commit on checkpatch of staging
tree was on April 16th, where as last commit in linux-next is on
June 19th. And if you use this checkpatch you will see these warnings
also. :)

regards
sudip
