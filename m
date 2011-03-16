From: Yannick Heneault <yannick_heneault@matrox.com>
Date: Wed, 16 Mar 2011 19:58:09 +0000
Subject: Re: [PATCH v2] matroxfb: remove incorrect Matrox G200eV support
Message-Id: <4D811651.6020607@matrox.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110301175026.GA18770@us.ibm.com> <AANLkTikwSXN8VgDaoUqfHcxoTNxW9uA4D2fUtRLuLbHo@mail.gmail.com> <20110304202905.GB27190@tux1.beaverton.ibm.com> <1299488356.9759.2.camel@pasglop> <20110311222337.GC7614@us.ibm.com>
In-Reply-To: <20110311222337.GC7614@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gary Hade <garyhade@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, djwong@us.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Helt <krzysztof.h1@wp.pl>, Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@linux-foundation.org>

It impossible that this patch should have work on a system. The patch 
only declare the G200eV as a regular G200 which is not case. Many 
registers are different, including at least the PLL programming 
sequence. If the G200eV is programmed like a regular G200, it will not 
display anything.

Yannick

On 03/11/2011 05:23 PM, Gary Hade wrote:
> On Mon, Mar 07, 2011 at 07:59:16PM +1100, Benjamin Herrenschmidt wrote:
>    
>> On Fri, 2011-03-04 at 12:29 -0800, Darrick J. Wong wrote:
>>      
>>> This is all quite strange -- 2.5 years ago when I wrote the patch it
>>> seemed to
>>> work ok.  On newer revisions of the x3650M2 it seems broken.  The
>>> original
>>> machine I wrote it for was cut up ages ago.
>>>
>>> I suppose we could simply blacklist any G200eV with a subsystem vendor
>>> ID of
>>> 0x1014 (IBM) until we figure out how to correct the driver.  Our
>>> customers will
>>> be deprived, but as it seems to be broken across most of our product
>>> lines I
>>> doubt any of them are making serious use of it anyway. :)
>>>
>>> Something like this?
>>>        
>> Does X work with the open source drivers ?
>>      
> Yes, X works fine on at least the IBM System x boxes that have
> the Matrox G200eV.
>
>    
>> In that case a better
>> approach would be to try to figure out what's different between the way
>> the 2 drivers setup the card registers and fix matroxfb..
>>      
> I suppose someone could attempt this but with vesafb available as
> an alternate fb provider and no known demand for repaired G200eV
> support in matroxfb, I am not sure what benefit it would provide.
>
> Gary
>
>
>    

