From: Juston Li <juston.h.li@gmail.com>
Date: Thu, 25 Jun 2015 16:26:00 +0000
Subject: Re: [PATCH v3 11/19] staging: sm750fb: consistent spacing around operators
Message-Id: <CAFow2F9=DhqioyV=tha=KBiTi0pz=Ee+NJJL2up41jUUcF66xg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
	<1435163120-3253-11-git-send-email-juston.h.li@gmail.com>
	<20150625115618.GC13366@sudip-PC>
In-Reply-To: <20150625115618.GC13366@sudip-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: teddy.wang@siliconmotion.com, Greg KH <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Jun 25, 2015 at 4:56 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> On Wed, Jun 24, 2015 at 09:25:12AM -0700, Juston Li wrote:
>> fixes checkpatch.pl error:
>> ERROR: need consistent spacing around ''
> little bit confused.
> 1) Your subject says consistent space around operators but here it says
>         around ''

The specific checkpatch.pl error was different for each error, the quotes
were suppose to contain the specific operator but I left it out so that there
would be one generic error message. The quotes left behind were confusing,
sorry.

> 2) Considering that you are giving consitent space around operators, then
>         i think you have missed few operators like '|','&',':' in this
>         patch.
>

These were the only instances the checkpatch.pl error came up. This patch
only fixes even spacing around a specific operator. Other operators either
have even or no spacing around them with PATCH 11/19 fixing any operators
with spacing around required. This leaves operators that checkpatch deems
spacing as optional which I left as a separate issue to be addressed of making
optional spacing of operators consistent with each other.

Thanks
Juston
