From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 02 Apr 2015 22:54:44 +0000
Subject: Re: [PATCH v1 06/47] mtrr: add __arch_phys_wc_add()
Message-Id: <CAB=NE6WRds0VdnmF8Asix=4TNE4qZWZQmftDoqgyG2E9wnyg3g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-7-git-send-email-mcgrof@do-not-panic.com>
 <CAErSpo7wazwgkEHkLixA88Lcq1Te564Xdd6k=6292JdT3hu8pw@mail.gmail.com>
 <20150402205520.GX5622@wotan.suse.de> <CAErSpo5mBtLuMcRJBYuxXqGBJRkqzQDQiimVgeLk2k+ztyCCCw@mail.gmail.com>
In-Reply-To: <CAErSpo5mBtLuMcRJBYuxXqGBJRkqzQDQiimVgeLk2k+ztyCCCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Thu, Apr 2, 2015 at 3:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [-cc Venkatesh, Suresh]
>
> On Thu, Apr 2, 2015 at 3:55 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>> On Thu, Apr 02, 2015 at 03:21:22PM -0500, Bjorn Helgaas wrote:
>>> On Fri, Mar 20, 2015 at 6:17 PM, Luis R. Rodriguez
>>> <mcgrof@do-not-panic.com> wrote:
>>> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
>>> > This is *only* a transitive API -- and as such no new
>>> > drivers are ever expected to use this.
>>>
>>> "transient"?  Do you mean you intend to remove this API in the near future?
>>
>> That's correct, the problem is that in order to use PAT cleanly we'd need to
>> change these drivers ...
>
> I was just trying to ask whether you intended to write "transient"
> instead of "transitive."  But I'm not doing a very good job :)

Yes, corrected, thanks.

 Luis
