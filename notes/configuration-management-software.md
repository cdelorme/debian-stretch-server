
# configuration management software

Tools like `ansible`, `chef`, `puppet`, `salt`, _and many more_, are in my eyes all garbage.

The only benefits they provide are enhanced template management and error handling.  _It's arguable whether reducing the barrier to entry is a "benefit" when you have to deal with problems and the folks who setup your systems can't troubleshoot since they depend on third parties to do all the real work._

**They are worse at literally everything else.**  One of the largest problems is how they attempt to enforce conflicting ideologies onto configuration (eg. "The one true way to X").

Tools like `chef` and `puppet` attempt to parallelize under the initial assumption that configuration order does not matter, which is hilarious when you watch commands attempt to edit files before those files exist due to package installation.

By virtue of attempting to repurpose existing machines they work against the notion of cattle-not-pets.  _It's a mistake to assume that a machine can always be brought back to a consistent state to begin with, let alone the notion that any automation could do so sanely._

They are slower, especially at small scale, than a simple bash script.  _Depending on the amount of modules they can be literally tens of thousands of files versus a hundred lines of shell._

They take at least twice as much effort to translate known bash commands into a custom DSL, and to test that the DSL behaves as expected.

The use of third party tools obfuscates the level of effort, leaving _you_ with catastrophic failures when those third parties fail to maintain _your_ dependencies.

With `ansible` as an exception, most require additional software installed on your machines.

In almost all cases the "correct" usage of these tools involves having a management or control cluster that is aware of and issues commands against your fleet of machines.  _This is added complexity and expense for you and your teams to pay out the nose for the opportunity to manage._

There are cases where they work, such as when you are creating highly modular configuration.  However, I will always prefer simplicity.
