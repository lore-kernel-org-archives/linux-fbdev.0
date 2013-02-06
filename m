From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 06 Feb 2013 14:44:34 +0000
Subject: Re: CDF meeting @FOSDEM report
Message-Id: <CADnq5_P1GFbAwoe9kTeARq8ZLP1tOBc9Rn1h2KrRYxkoLxLXfw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1990856.qS9uisuiVF@avalon>
	<51123A5F.9050604@ti.com>
In-Reply-To: <51123A5F.9050604@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Tom Gall <tom.gall@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@avionic-desi.gn.de>, Mark Zhang <markz@nvidia.com>, dri-devel@lists.freedesktop.org, Sunil Joshi <joshi@samsung.com>, linaro-mm-sig@lists.linaro.org, =?ISO-8859-1?Q?St=E9phane_Marchesin?= <stephane.marchesin@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Jesse Barnes <jesse.barnes@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastien Guiriec <s-guiriec@ti.com>, Alexandre Courbot <acourbot@nvidia.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Ragesh Radhakrishnan <Ragesh.R@linaro.org>, linux-media@vger.kernel.org

On Wed, Feb 6, 2013 at 6:11 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> On 2013-02-06 00:27, Laurent Pinchart wrote:
>> Hello,
>>
>> We've hosted a CDF meeting at the FOSDEM on Sunday morning. Here's a summary
>> of the discussions.
>
> Thanks for the summary. I've been on a longish leave, and just got back,
> so I haven't read the recent CDF discussions on lists yet. I thought
> I'll start by replying to this summary first =).
>
>> 0. Abbreviations
>> ----------------
>>
>> DBI - Display Bus Interface, a parallel video control and data bus that
>> transmits data using parallel data, read/write, chip select and address
>> signals, similarly to 8051-style microcontroller parallel busses. This is a
>> mixed video control and data bus.
>>
>> DPI - Display Pixel Interface, a parallel video data bus that transmits data
>> using parallel data, h/v sync and clock signals. This is a video data bus
>> only.
>>
>> DSI - Display Serial Interface, a serial video control and data bus that
>> transmits data using one or more differential serial lines. This is a mixed
>> video control and data bus.
>
> In case you'll re-use these abbrevs in later posts, I think it would be
> good to mention that DPI is a one-way bus, whereas DBI and DSI are
> two-way (perhaps that's implicit with control bus, though).
>
>> 1. Goals
>> --------
>>
>> The meeting started with a brief discussion about the CDF goals.
>>
>> Tomi Valkeinin and Tomasz Figa have sent RFC patches to show their views of
>> what CDF could/should be. Many others have provided very valuable feedback.
>> Given the early development stage propositions were sometimes contradictory,
>> and focused on different areas of interest. We have thus started the meeting
>> with a discussion about what CDF should try to achieve, and what it shouldn't.
>>
>> CDF has two main purposes. The original goal was to support display panels in
>> a platform- and subsystem-independent way. While mostly useful for embedded
>> systems, the emergence of platforms such as Intel Medfield and ARM-based PCs
>> that blends the embedded and PC worlds makes panel support useful for the PC
>> world as well.
>>
>> The second purpose is to provide a cross-subsystem interface to support video
>> encoders. The idea originally came from a generalisation of the original RFC
>> that supported panels only. While encoder support is considered as lower
>> priority than display panel support by developers focussed on display
>> controller driver (Intel, Renesas, ST Ericsson, TI), companies that produce
>> video encoders (Analog Devices, and likely others) don't share that point of
>> view and would like to provide a single encoder driver that can be used in
>> both KMS and V4L2 drivers.
>
> What is an encoder? Something that takes a video signal in, and lets the
> CPU store the received data to memory? Isn't that a decoder?
>
> Or do you mean something that takes a video signal in, and outputs a
> video signal in another format? (transcoder?)

In KMS parlance, we have two objects a crtc and an encoder.  A crtc
reads data from memory and produces a data stream with display timing.
 The encoder then takes that datastream and timing from the crtc and
converts it some sort of physical signal (LVDS, TMDS, DP, etc.).  It's
not always a perfect match to the hardware.  For example a lot of GPUs
have a DVO encoder which feeds a secondary encoder like an sil164 DVO
to TMDS encoder.

Alex
