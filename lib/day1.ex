defmodule AocKata.Day1 do
  @doc """
  After feeling like you've been falling for a few minutes, you look at the device's tiny screen. "Error: Device must be calibrated before first use. Frequency drift detected. Cannot maintain destination lock." Below the message, the device shows a sequence of changes in frequency (your puzzle input). A value like +6 means the current frequency increases by 6; a value like -3 means the current frequency decreases by 3.

  For example, if the device displays frequency changes of +1, -2, +3, +1, then starting from a frequency of zero, the following changes would occur:

  Current frequency  0, change of +1; resulting frequency  1.
  Current frequency  1, change of -2; resulting frequency -1.
  Current frequency -1, change of +3; resulting frequency  2.
  Current frequency  2, change of +1; resulting frequency  3.
  In this example, the resulting frequency is 3.

  Here are other example situations:

  +1, +1, +1 results in  3
  +1, +1, -2 results in  0
  -1, -2, -3 results in -6
  Starting with a frequency of zero, what is the resulting frequency after all of the changes in frequency have been applied?

  `frequency_changes` is a stream of the freqency_changes (e.g. `["+1", "-10"]`)

  Hint 1: Streams can be consumed with most functions of the `Enum` module.

  Hint 2: Try solving the problem with `Enum.reduce/3`.
  """
  @spec resulting_frequency(Enumerable.t()) :: integer
  def resulting_frequency(frequency_changes) do
    # frequency_changes
    # |> Enum.map(fn x ->
    #               x |> Integer.parse
    #                 |> elem(0) end)
    # |> Enum.sum
  #  frequency_changes
    # |> Enum.reduce(0, fn x, acc -> (x |> Integer.parse |> elem(0)) + acc end)

    rf(frequency_changes, 0)
  end
defp rf([head|tail], acc) do
  acc = head
  |> Integer.parse
  |> elem(0)
  |> Kernel.+(acc)
  rf(tail, acc)
end
defp rf([], acc), do: acc




  @doc """
  You notice that the device repeats the same frequency change list over and over. To calibrate the device, you need to find the first frequency it reaches twice.

  For example, using the same list of changes above, the device would loop as follows:

  Current frequency  0, change of +1; resulting frequency  1.
  Current frequency  1, change of -2; resulting frequency -1.
  Current frequency -1, change of +3; resulting frequency  2.
  Current frequency  2, change of +1; resulting frequency  3.
  (At this point, the device continues from the start of the list.)
  Current frequency  3, change of +1; resulting frequency  4.
  Current frequency  4, change of -2; resulting frequency  2, which has already been seen.
  In this example, the first frequency reached twice is 2. Note that your device might need to repeat its list of frequency changes many times before a duplicate frequency is found, and that duplicates might be found while in the middle of processing the list.

  Here are other examples:

  +1, -1 first reaches 0 twice.
  +3, +3, +4, -2, -4 first reaches 10 twice.
  -6, +3, +8, +5, -6 first reaches 5 twice.
  +7, +7, -2, -7, -4 first reaches 14 twice.

  `frequency_changes` is a stream of the freqency_changes (e.g. `["+1", "-10"]`)

  Hint 3: Try `Enum.reduce_while/3`
  """
  @spec resulting_frequency_fixed(Enumerable.t()) :: integer
  def resulting_frequency_fixed(frequency_changes) do
    # frequency_changes = Stream.repeatedly(fn -> frequency_changes end) |> Stream.flat_map(& &1)
    (frequency_changes ++ frequency_changes ++ frequency_changes)
    |> Enum.map(fn x ->
                  x |> Integer.parse
                    |> elem(0) end)
    |> Enum.reduce_while([0], fn x, [head|_] = acc ->
        if Enum.member? acc, (x + head) do
          {:halt, (x + head)}
        else
          {:cont, [x + head|acc]}
        end
    end)
    |> case do
        [head|_] -> head
        acc -> acc
       end
  end
end
