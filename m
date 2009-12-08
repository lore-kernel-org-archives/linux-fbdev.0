From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 2/4] da850/omap-l138: Add callback to control LCD panel
	power
Date: Tue, 08 Dec 2009 14:45:28 -0800
Message-ID: <87bpi913w7.fsf@deeprootsystems.com>
References: <1259304249-19439-1-git-send-email-chaithrika@ti.com>
	<871vj52vyt.fsf@deeprootsystems.com>
	<20091208122551.f632c665.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20091208122551.f632c665.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> (Andrew
	Morton's message of "Tue\, 8 Dec 2009 12\:25\:51 -0800")
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org

Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> writes:

> On Tue, 08 Dec 2009 09:53:46 -0800
> Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:
>
>> Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org> writes:
>> 
>> > Add the platform specific callback to control LCD panel and
>> > backlight power.
>> >
>> > Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
>> > ---
>> > This patch applies to DaVinci GIT tree at
>> > http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=summary
>> 
>> Andrew,
>> 
>> I see you have pulled this series into -mm.  Thanks.  The
>> drivers/video/* changes in patches 1,3 and 4 should go upstream
>> through you, but I'd like to request that you drop this patch (PATCH
>> 2/4) from your queue, and I will queue it in davinci-next.
>
> I autodrop patches when they turn up in linux-next.  So if you want to
> merge something then please just merge away, then I'll drop my copy.

OK.

> This way patches don't get lost, and I get to check whether the patch
> which was in linux-next matches the version I had, and whether the patch
> which was merged into linux-next is missing any followup patches which
> I had accumulated against the original.

Sounds good.  Thanks for the explanation.

Kevin
