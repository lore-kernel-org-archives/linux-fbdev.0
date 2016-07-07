From: "Jan Beulich" <JBeulich@suse.com>
Date: Thu, 07 Jul 2016 10:03:53 +0000
Subject: Re: [PATCH] xen-fbfront: correct return value checks on xenbus_scanf()
Message-Id: <577E452902000078000FC175@prv-mh.provo.novell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <577E258502000078000FBE6F@suse.com> <577E241D.8040908@suse.com>
In-Reply-To: <577E241D.8040908@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Vrabel <david.vrabel@citrix.com>, Juergen Gross <JGross@suse.com>
Cc: xen-devel <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, linux-fbdev <linux-fbdev@vger.kernel.org>

>>> On 07.07.16 at 11:42, <JGross@suse.com> wrote:
> On 07/07/16 09:48, Jan Beulich wrote:
>> Only a positive return value indicates success.
> 
> Hmm, I'm not convinced on this change (and the similar others as
> well). From xenbus.h:
> 
> /* Single read and scanf: returns -errno or num scanned if > 0. */
> 
> There should be no case for xenbus_scanf() returning 0. And looking
> into the functions proofs this is correct.

I don't think it is appropriate for callers to assume a currently
impossible return value indicates success.

Jan

